//==========================================================
// Testbench for seq_and_comb
//==========================================================

module tb_seq_and_comb;

    reg clk;
    reg data_in;
    wire q_out;

    reg a_in, b_in, sel_in;
    wire y_out;

    // Instantiate DUT
    seq_and_comb DUT (
        .clk(clk),
        .data_in(data_in),
        .q_out(q_out),
        .a_in(a_in),
        .b_in(b_in),
        .sel_in(sel_in),
        .y_out(y_out)
    );

    // ----------------------------
    // Clock Generation (10ns period)
    // ----------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ----------------------------
    // VCD file for waveform
    // ----------------------------
    initial begin
        $dumpfile("seq_and_comb.vcd");
        $dumpvars(0, tb_seq_and_comb);
    end

    // ----------------------------
    // Monitor all changes
    // ----------------------------
    initial begin
        $monitor("Time=%0t | clk=%b  data_in=%b  q_out=%b | sel=%b  a=%b  b=%b  y_out=%b",
                 $time, clk, data_in, q_out, sel_in, a_in, b_in, y_out);
    end

    // ----------------------------
    // Test Stimulus
    // ----------------------------
    initial begin
        // Initial values
        data_in = 0;
        a_in = 0; b_in = 1; sel_in = 0;

        // Sequential & combinational tests
        #10 data_in = 1;
        #10 data_in = 0;

        // MUX tests
        #10 sel_in = 0; a_in = 0; b_in = 1;
        #10 sel_in = 1; a_in = 1; b_in = 0;
        #10 sel_in = 0; a_in = 1; b_in = 0;
        #10 sel_in = 1; a_in = 0; b_in = 1;

        #30 $finish;
    end

endmodule
