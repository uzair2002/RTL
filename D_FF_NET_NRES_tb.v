module tb_D_FF_NET_NRES;

    reg d_in, clk, n_res;
    wire q_out;

    // Instantiate DUT
    D_FF_NET_NRES DUT (
        .d_in(d_in),
        .clk(clk),
        .n_res(n_res),
        .q_out(q_out)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // VCD dump
    initial begin
        $dumpfile("D_FF_NET_NRES.vcd");
        $dumpvars(0, tb_D_FF_NET_NRES);
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | clk=%b n_res=%b d_in=%b | q_out=%b",
                 $time, clk, n_res, d_in, q_out);
    end

    // Stimulus
    initial begin
        // Initial values
        d_in  = 0;
        n_res = 0;   // assert reset
        #12;

        n_res = 1;   // deassert reset
        #10;

        d_in = 1;    // captured at next posedge
        #10;

        d_in = 0;
        #10;

        d_in = 1;
        #10;

        // Assert reset asynchronously
        n_res = 0;
        #7;

        n_res = 1;
        d_in = 0;
        #20;

        $finish;
    end

endmodule
