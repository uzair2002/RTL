module tb_Gray_Counter2;

    reg clk;
    reg reset_n;
    reg inc;
    reg full;
    wire [3:0] gray;

    // DUT instantiation
    Gray_Counter2 #(4) DUT (
        .gray(gray),
        .clk(clk),
        .full(full),
        .inc(inc),
        .reset_n(reset_n)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Dump VCD file for GTKWave
    initial begin
        $dumpfile("Gray_Counter2.vcd");
        $dumpvars(0, tb_Gray_Counter2);
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | clk=%b reset_n=%b inc=%b full=%b | gray=%b",
                  $time, clk, reset_n, inc, full, gray);
    end

    // Apply stimulus
    initial begin
        // Initial values
        reset_n = 0;
        inc = 0;
        full = 0;

        // Release reset
        #12 reset_n = 1;

        // Count up while not full
        #10 inc = 1; full = 0;
        #40;

        // Freeze counter (full=1)
        #10 full = 1; inc = 1;
        #20;

        // Resume counting
        #10 full = 0;

        #40;

        // Apply reset again
        #10 reset_n = 0;
        #10 reset_n = 1;

        #30 $finish;
    end

endmodule
