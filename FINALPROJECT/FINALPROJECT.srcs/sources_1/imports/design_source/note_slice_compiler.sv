module note_slice_compiler(
    input logic clk,           // 100MHz system clock
    input logic reset,
    input logic playing,
    input logic [63:0] note_data,
    output logic mono_out
);
    
    // PWM parameters
    localparam PWM_BITS = 8;
    
    // Clock divider initialization
    initial begin
        clk_50MHz = 0;
    end
    
    // Timing counters
    logic [12:0] sample_counter;  // hardcoded for 5882
    logic [PWM_BITS-1:0] pwm_counter;
    
    // Audio processing
    logic [7:0] current_sample;
    logic [15:0] sample_acc;
    logic [4:0] active_notes;
    
    // Note frequency increments
    logic [6:0] D5_i = 71, CS5_i = 67, C5_i = 63, B4_i = 60, AS4_i = 56, A4_i = 53, GS4_i = 50, G4_i = 47;
    logic [6:0] FS4_i = 45, F4_i = 42, E4_i = 40, DS4_i = 37, D4_i = 35, CS4_i = 33, C4_i = 32, B3_i = 30;
    logic [6:0] AS3_i = 28, A3_i = 27, GS3_i = 25, G3_i = 24, FS3_i = 22, F3_i = 21, E3_i = 20, DS3_i = 19;
    logic [6:0] D3_i = 18, CS3_i = 17, C3_i = 16, B2_i = 15, AS2_i = 14;
    
    // Wave table ROM
    logic [12:0] rom_addr;
    logic [7:0] wave_sample;
    
    blk_mem_gen_1 wave_rom (
        .clka(clk),
        .addra(rom_addr),
        .douta(wave_sample)
    );

    // Sample clock generation (17kHz)
    logic sample_clk;
    always_ff @(posedge clk) begin
        if (reset || !playing) begin
            sample_counter <= '0;
            sample_clk <= 0;
        end else if (sample_counter >= 13'd5881) begin  // 5882-1, hardcoded
            sample_counter <= '0;
            sample_clk <= 1;
        end else begin
            sample_counter <= sample_counter + 1;
            sample_clk <= 0;
        end
    end

    // Note processing
    logic [4:0] note_idx;
    logic [1:0] note_code;
    logic [10:0] phase_acc;
    logic [6:0] phase_inc;
    logic [4:0] note_pos;

    // Phase increment lookup based on note position
    always_comb begin
        note_pos = note_idx[4:0];
        case (note_pos)
            0  : phase_inc = D5_i;
            1  : phase_inc = CS5_i;
            2  : phase_inc = C5_i;
            3  : phase_inc = B4_i;
            4  : phase_inc = AS4_i;
            5  : phase_inc = A4_i;
            6  : phase_inc = GS4_i;
            7  : phase_inc = G4_i;
            8  : phase_inc = FS4_i;
            9  : phase_inc = F4_i;
            10 : phase_inc = E4_i;
            11 : phase_inc = DS4_i;
            12 : phase_inc = D4_i;
            13 : phase_inc = CS4_i;
            14 : phase_inc = C4_i;
            15 : phase_inc = B3_i;
            16 : phase_inc = AS3_i;
            17 : phase_inc = A3_i;
            18 : phase_inc = GS3_i;
            19 : phase_inc = G3_i;
            20 : phase_inc = FS3_i;
            21 : phase_inc = F3_i;
            22 : phase_inc = E3_i;
            23 : phase_inc = DS3_i;
            24 : phase_inc = D3_i;
            25 : phase_inc = CS3_i;
            26 : phase_inc = C3_i;
            27 : phase_inc = B2_i;
            28 : phase_inc = AS2_i;
            default : phase_inc = 0;
        endcase
    end

    // Clock divider for 50MHz operation
    logic clk_50MHz;
    always_ff @(posedge clk) begin
        clk_50MHz <= ~clk_50MHz;
    end

    always_ff @(posedge clk_50MHz) begin
        if (reset || !playing) begin
            note_idx <= '0;
            phase_acc <= '0;
            current_sample <= 8'h80;  // Midpoint (silence)
            sample_acc <= '0;
            active_notes <= '0;
        end else if (sample_clk) begin
            // Reset for new sample
            note_idx <= '0;
            phase_acc <= '0;
            sample_acc <= '0;
            active_notes <= '0;
        end else begin
            // Process one note per clock
            if (note_idx < 31) begin
                note_code = note_data[note_idx*2 +: 2];
                if (note_code != 2'b00) begin
                    // Accumulate phase for this note
                    phase_acc <= phase_acc + phase_inc;
                    sample_acc <= sample_acc + wave_sample;
                    active_notes <= active_notes + 1;
                end
                note_idx <= note_idx + 1;
            end
            
            // Update final sample
            if (note_idx == 31) begin
                if (active_notes > 0)
                    current_sample <= sample_acc / active_notes;
                else
                    current_sample <= 8'h00;
            end
        end
    end

    // ROM addressing
    always_comb begin
        if (note_code != 2'b00) begin
            rom_addr = {note_code - 1, phase_acc};
        end else begin
            rom_addr = '0;
        end
    end

    // PWM generation (direct from system clock)
    always_ff @(posedge clk) begin
        if (reset || !playing) begin
            pwm_counter <= '0;
            mono_out <= 1'b0;
        end else begin
            pwm_counter <= pwm_counter + 1;
            mono_out <= (pwm_counter < current_sample);
        end
    end

endmodule
