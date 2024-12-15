`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 12:49:41 AM
// Design Name: 
// Module Name: note_slice_compiler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module note_slice_compiler(
    input logic clk,
    input logic playing,
    input logic [63:0] note_data,
    input logic reset,
    output logic mono_out
    );
    
    
    logic [1:0] note_code;      // holds the note code for decoding purposes
    logic [1:0] t_index;        // used to access proper wave form samples skipping silent notes
    logic [11:0] phase_acc;     // holds the address used to index the wave sample table
    logic [6:0] phase_inc;      // adds an increment to the phase_acc based on the note counter
    logic [15:0] sample_sum;    // holds the sum of sample values across 32 notes
    logic [4:0] sum_counter;    // counts how many actual note samples have been added, used for division
    logic [7:0] output_byte;    // holds the final sample byte to be played by PWM after sum and avg
    logic [7:0] PWM_counter;    // compared  with sample to control PWM output on/off
                                // 8 Mhz by default, tells how many 1/16th notes per second
                                
    // Reciprocal lookup table (fixed point 8.8 format)
    logic [15:0] reciprocal_lut [1:32];
    initial begin
        reciprocal_lut[1]  = 16'h0100;  // 1.000
        reciprocal_lut[2]  = 16'h0080;  // 0.500
        reciprocal_lut[3]  = 16'h0055;  // 0.333
        reciprocal_lut[4]  = 16'h0040;  // 0.250
        reciprocal_lut[5]  = 16'h0033;  // 0.200
        reciprocal_lut[6]  = 16'h002A;  // 0.167
        reciprocal_lut[7]  = 16'h0024;  // 0.143
        reciprocal_lut[8]  = 16'h0020;  // 0.125
        reciprocal_lut[9]  = 16'h001C;  // 0.111
        reciprocal_lut[10] = 16'h0019;  // 0.100
        reciprocal_lut[11] = 16'h0017;  // 0.091
        reciprocal_lut[12] = 16'h0015;  // 0.083
        reciprocal_lut[13] = 16'h0013;  // 0.077
        reciprocal_lut[14] = 16'h0012;  // 0.071
        reciprocal_lut[15] = 16'h0011;  // 0.067
        reciprocal_lut[16] = 16'h0010;  // 0.063
        reciprocal_lut[17] = 16'h000F;  // 0.059
        reciprocal_lut[18] = 16'h000E;  // 0.056
        reciprocal_lut[19] = 16'h000D;  // 0.053
        reciprocal_lut[20] = 16'h000D;  // 0.050
        reciprocal_lut[21] = 16'h000C;  // 0.048
        reciprocal_lut[22] = 16'h000B;  // 0.045
        reciprocal_lut[23] = 16'h000B;  // 0.043
        reciprocal_lut[24] = 16'h000A;  // 0.042
        reciprocal_lut[25] = 16'h000A;  // 0.040
        reciprocal_lut[26] = 16'h000A;  // 0.038
        reciprocal_lut[27] = 16'h0009;  // 0.037
        reciprocal_lut[28] = 16'h0009;  // 0.036
        reciprocal_lut[29] = 16'h0009;  // 0.034
        reciprocal_lut[30] = 16'h0008;  // 0.033
        reciprocal_lut[31] = 16'h0008;  // 0.032
        reciprocal_lut[32] = 16'h0008;  // 0.031
    end
    //logic s_clk;                // 17 kHz sample clock, pulses high at the start of each sample every ~.06 ms for ~.03 ms
    //logic s_sync;               // used to sync for loop within note sampling block to the sample clock
    logic PWM_clk;              // 50 Mhz, used to drive the PWM for sample output
    logic pwm_reset;            // resets the PWM counter
    //logic is_perc;              // tells whether we are reading note samples from phase osc. or drum samples
    logic is_ready;             // flips high when output sample byte finishes computation
    logic is_ready_pipe;
    logic [7:0] output_byte_pipe;
    logic [4:0] sum_counter_pipe;
    
    // phase increment values for accumulator note frequency shifting
    logic [6:0] D5_i = 71, CS5_i = 67, C5_i = 63, B4_i = 60, AS4_i = 56, A4_i = 53, GS4_i = 50, G4_i = 47;
    logic [6:0] FS4_i = 45, F4_i = 42, E4_i = 40, DS4_i = 37, D4_i = 35, CS4_i = 33, C4_i = 32, B3_i = 30;
    logic [6:0] AS3_i = 28, A3_i = 27, GS3_i = 25, G3_i = 24, FS3_i = 22, F3_i = 21, E3_i = 20, DS3_i = 19;
    logic [6:0] D3_i = 18, CS3_i = 17, C3_i = 16, B2_i = 15, AS2_i = 14;

    parameter CLK = 100_000_000;
    // frequency used to sample the wave table, heard at audio output
    parameter sampler_freq = 17_000;
    // PWM signal out frequency, much greater than sampling frequency for accurate reconstruction
    parameter PWM_freq = 50_000_000;
    

    logic [13:0] wt_addr; // actual address value used to find samples in wave table
    // logic [13:0] dt_addr; // address value used to find samples in drum table
    //logic [11:0] low_twelve; // holds the lower 10 bits used to index drum samples
    logic [7:0] w_sample_reg; // holds a temporary sample value from wave table
    //logic [7:0] d_sample_reg; // holds a temporary sample value from drum table
    logic [13:0] rom_data; // ROM data
    logic [14:0] counter;
    logic n_clk;
    
    assign w_sample_reg = rom_data[7:0];
    assign PWM_clk = clk;
    
    blk_mem_gen_1 BRAM_ROM(
        .clka(clk),
        .addra(wt_addr),
        .douta(rom_data)
        );

    // percussion samples being at note index 29


    always_comb begin
        t_index[1] <= note_code[1] & note_code[0]; // these two lines account for having no silent waveform
        t_index[0] <= note_code[1] & ~(note_code[0]);
    end

    assign wt_addr = {t_index, phase_acc}; // concatenate newly indexed waveform code with sample address
    //assign dt_addr = {t_index, low_twelve}; // concatenate newly indexed waveform with sample address

    // note clock will be used for the sampling block below, which will output 
    // 2125 samples per 8 Hz cycle using a state machine driven at the sampling
    // rate of 17 kHz
    
    always_ff @ (posedge clk) begin
        if (!playing) begin
            counter <= '0;
        end else if (playing) begin
            if (counter == 5882) begin
                counter <= '0;
                n_clk <=1'b1;
            end
            else begin
                counter <= counter + 1;
                n_clk <= 1'b0;
            end
        end
    end
    
    logic [11:0] j;
    
    always_ff @ (posedge n_clk or posedge reset) begin
        if (!playing | reset) begin
            j <= 12'b000000000000;
        end
    else
        if (j == 12'd2124) begin
            j <= 12'b000000000000;
        end
        else
            j = j + 1;
    end
    
    logic [4:0] i;
    always_ff @ (posedge clk or posedge reset) begin
        if (reset | !playing) begin
            i <= 5'b00000;
        end
        else
            if (i == 5'b11111) begin
                i <= 5'b00000;
            end
            else
                i = i + 1;
    end
    logic is_ready_pipe;
    logic [7:0] output_byte_pipe;
    logic [4:0] sum_counter_pipe;
    
    always_ff @(posedge clk) begin
        if (n_clk) begin
            is_ready_pipe <= 0;
            output_byte_pipe <= '0;
            sum_counter_pipe <= '0;
        end else begin
            is_ready_pipe <= is_ready_pipe;
            output_byte_pipe <= output_byte_pipe;
            sum_counter_pipe <= sum_counter_pipe;
        end
    end
    

always_comb begin
    note_code = note_data[i*2 +: 2];
    case (i)
        28 : phase_inc = D5_i;
        27 : phase_inc = CS5_i;
        26 : phase_inc = C5_i;
        25 : phase_inc = B4_i;
        24 : phase_inc = AS4_i;
        23 : phase_inc = A4_i;
        22 : phase_inc = GS4_i;
        21 : phase_inc = G4_i;
        20 : phase_inc = FS4_i;
        19 : phase_inc = F4_i;
        18 : phase_inc = E4_i;
        17 : phase_inc = DS4_i;
        16 : phase_inc = D4_i;
        15 : phase_inc = CS4_i;
        14 : phase_inc = C4_i;
        13 : phase_inc = B3_i;
        12 : phase_inc = AS3_i;
        11 : phase_inc = A3_i;
        10 : phase_inc = GS3_i;
        9  : phase_inc = G3_i;
        8  : phase_inc = FS3_i;
        7  : phase_inc = F3_i;
        6  : phase_inc = E3_i;
        5  : phase_inc = DS3_i;
        4  : phase_inc = D3_i;
        3  : phase_inc = CS3_i;
        2  : phase_inc = C3_i;
        1  : phase_inc = B2_i;
        0  : phase_inc = AS2_i;
        default : phase_inc = 0;
    endcase
end

logic [7:0] output_pipe;

always_ff @(posedge clk) begin
    if (reset | !playing) begin
        sample_sum <= '0;
        phase_acc <= '0;
        sum_counter <= '0;
        //output_byte <= '0;
        is_ready <= 1'b0;
    end
    else if (n_clk) begin
        sample_sum <= '0;
        sum_counter <= '0;
        phase_acc <= '0;
        is_ready <= 1'b0;
    end
    else begin
        if (note_code != 2'b00) begin
            phase_acc <= phase_acc + (phase_inc * j);
            sample_sum <= sample_sum + w_sample_reg;
            sum_counter <= sum_counter + 1;
        end
        
        if (i == 5'b11111) begin
            // is_ready <= 1'b1;
            output_pipe <= (sum_counter > 0) ? ((sample_sum * reciprocal_lut[sum_counter]) >> 8) : 8'b0;
        end
        /*
        if (i == 5'b11111) begin
            output_byte <= (sum_counter > 0) ? ((sample_sum * reciprocal_lut[sum_counter]) >> 8) : 8'b0;
            is_ready <= 1'b1;
        end */
    end
end
always_ff @(negedge n_clk) begin
    //if (is_ready)
        output_byte <= output_pipe;
    //else
        //output_byte <= '0;
end

    always_ff @(posedge clk) begin
        if (n_clk) begin
            is_ready_pipe <= 0;
            output_byte_pipe <= '0;
            sum_counter_pipe <= '0;
        end else begin
            is_ready_pipe <= is_ready_pipe;
            output_byte_pipe <= output_byte_pipe;
            sum_counter_pipe <= sum_counter_pipe;
        end
    end

    always_ff @(posedge PWM_clk) begin
        if (reset | !playing) begin
            PWM_counter <= '0;
            mono_out <= 1'b0;
        end
        else begin
            PWM_counter <= PWM_counter + 1;
            mono_out <= (PWM_counter < output_byte);
        end
    end

endmodule
