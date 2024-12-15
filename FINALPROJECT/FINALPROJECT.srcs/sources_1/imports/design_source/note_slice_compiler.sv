module note_slice_compiler(
    input logic clk,           // 100MHz system clock
    input logic reset,
    input logic playing,
    input logic [63:0] note_data,
    output logic mono_out
);
    
    // PWM parameters
    localparam PWM_BITS = 8;
    
    // Timing counters
    logic [12:0] sample_counter;  // hardcoded for 5882
    logic [PWM_BITS-1:0] pwm_counter;
    
    // Audio processing
    logic [7:0] current_sample;
    logic [15:0] sample_acc;
    logic [4:0] active_notes;
    
    // Wave table ROM
    logic [13:0] rom_addr;
    logic [13:0] rom_data;
    logic [7:0] wave_sample;
    assign wave_sample = rom_data[7:0];
    
    blk_mem_gen_1 wave_rom (
        .clka(clk),
        .addra(rom_addr),
        .douta(rom_data)
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
    logic [11:0] phase_acc;

    always_ff @(posedge clk) begin
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
                    current_sample <= 8'h80;
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
