module note_slice_compiler(
    input logic clk,           // 100MHz system clock
    input logic reset,
    input logic playing,
    input logic [63:0] note_data,
    input logic step_tick,
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
    
    // Note frequency increments
    logic [7:0] D5_i = 60, CS5_i = 57, C5_i = 54, B4_i = 51, AS4_i = 48, A4_i = 45, GS4_i = 43, G4_i = 40;
    logic [7:0] FS4_i = 38, F4_i = 36, E4_i = 34, DS4_i = 32, D4_i = 30, CS4_i = 28, C4_i = 27, B3_i = 25;
    logic [7:0] AS3_i = 24, A3_i = 23, GS3_i = 21, G3_i = 20, FS3_i = 19, F3_i = 18, E3_i = 17, DS3_i = 16;
    logic [7:0] D3_i = 15, CS3_i = 14, C3_i = 13, B2_i = 13, AS2_i = 12;
    
    // Wave table ROMs
    logic [7:0] wave_sample_1, wave_sample_2;  // The selected samples from the ROMs
    logic [7:0] sine_sample_1, sine_sample_2;
    logic [7:0] square_sample_1, square_sample_2;
    logic [7:0] sawtooth_sample_1, sawtooth_sample_2;
    logic [11:0] rom_addr_12bit_1, rom_addr_12bit_2;  // ROM addresses for each voice
    logic [15:0] sample_acc_1, sample_acc_2;  // Separate accumulators
    logic found_first_note;  // Flag to track first note found
    
    sine_rom sine_wave (
        .clk(clk),
        .addr1(rom_addr_12bit_1),
        .addr2(rom_addr_12bit_2),
        .q1(sine_sample_1),
        .q2(sine_sample_2)
    );

    square_rom square_wave (
        .clk(clk),
        .addr1(rom_addr_12bit_1),
        .addr2(rom_addr_12bit_2),
        .q1(square_sample_1),
        .q2(square_sample_2)
    );

    sawtooth_rom sawtooth_wave (
        .clk(clk),
        .addr1(rom_addr_12bit_1),
        .addr2(rom_addr_12bit_2),
        .q1(sawtooth_sample_1),
        .q2(sawtooth_sample_2)
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
    logic [1:0] note_code, note_code_delayed, note_code_delayed_1;
    logic [11:0] phase_acc;
    logic [7:0] phase_inc;
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
        if (reset) begin
            clk_50MHz <= 0;
        end
        else begin
            clk_50MHz <= ~clk_50MHz;
        end
    end

    // Sample accumulation
    always_comb begin
        sample_acc = sample_acc_1 + sample_acc_2;
    end

    always_ff @(posedge clk) begin
        if (reset || !playing) begin
            note_idx <= '0;
            phase_acc_1 <= '0;
            phase_acc_2 <= '0;
            current_sample <= 8'h00;
            sample_acc_1 <= '0;
            sample_acc_2 <= '0;
            active_notes <= '0;
            note_code_1 <= 2'b00;
            note_code_2 <= 2'b00;
            note_code_delayed_1_1 <= 2'b00;
            note_code_delayed_1_2 <= 2'b00;
            found_first_note <= 0;
        end else if (sample_clk) begin
            note_idx <= '0;
            sample_acc_1 <= '0;
            sample_acc_2 <= '0;
            active_notes <= '0;
            found_first_note <= 0;
        end else if (step_tick) begin
            phase_acc_1 <= '0;
            phase_acc_2 <= '0;
        end else begin
            if (note_idx < 31) begin
                if (note_data[note_idx*2 +: 2] != 2'b00) begin
                    if (!found_first_note) begin
                        note_code_1 <= note_data[note_idx*2 +: 2];
                        note_code_delayed_1_1 <= note_code_1;
                        phase_acc_1 <= phase_acc_1 + phase_inc;
                        found_first_note <= 1;
                        active_notes <= active_notes + 1;
                    end else begin
                        note_code_2 <= note_data[note_idx*2 +: 2];
                        note_code_delayed_1_2 <= note_code_2;
                        phase_acc_2 <= phase_acc_2 + phase_inc;
                        active_notes <= active_notes + 1;
                    end
                end
                
                if (note_code_delayed_1_1 != 2'b00) begin
                    sample_acc_1 <= sample_acc_1 + wave_sample_1;
                end
                if (note_code_delayed_1_2 != 2'b00) begin
                    sample_acc_2 <= sample_acc_2 + wave_sample_2;
                end
                
                note_idx <= note_idx + 1;
            end else begin
                case (active_notes)
                    5'd1: current_sample <= sample_acc;     // No division for single note
                    5'd2: current_sample <= sample_acc >> 1; // Bit shift right for two notes
                    default: current_sample <= 8'h00;       // Silence otherwise
                endcase
            end
        end
    end

    // ROM addressing and wave sample selection
    always_comb begin
        // Default assignments
        wave_sample_1 = 8'h00;
        wave_sample_2 = 8'h00;
        
        // ROM addresses from phase accumulators
        rom_addr_12bit_1 = phase_acc_1[11:0];
        rom_addr_12bit_2 = phase_acc_2[11:0];
        
        // First voice sample selection
        if (note_code_delayed_1_1 == 2'b01)
            wave_sample_1 = sine_sample_1;
        else if (note_code_delayed_1_1 == 2'b10)
            wave_sample_1 = square_sample_1;
        else if (note_code_delayed_1_1 == 2'b11)
            wave_sample_1 = sawtooth_sample_1;
            
        // Second voice sample selection
        if (note_code_delayed_1_2 == 2'b01)
            wave_sample_2 = sine_sample_2;
        else if (note_code_delayed_1_2 == 2'b10)
            wave_sample_2 = square_sample_2;
        else if (note_code_delayed_1_2 == 2'b11)
            wave_sample_2 = sawtooth_sample_2;
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
