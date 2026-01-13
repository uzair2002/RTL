module tb_Gray_Counter();

    reg clk, reset, load_en;
    reg [3:0] data_in;
    wire [3:0] out;

    Gray_Counter DUT (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .load_en(load_en),
        .out(out)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Dumpfile for GTKWave
    initial begin
        $dumpfile("Gray_Counter.vcd");
        $dumpvars(0, tb_Gray_Counter);
    end

    initial begin
        $monitor("Time=%0t | reset=%b load_en=%b data_in=%b | out=%b | count(binary)=%d",
            $time, reset, load_en, data_in, out, DUT.count);
    end

    initial begin
        // Start
        reset = 1; load_en = 0; data_in = 0;
        #10 reset = 0;

        // Load custom value
        load_en = 1; data_in = 4'b0000;
        #10 load_en = 0;

        // Normal Gray counting
        #160;

        // Another load
        load_en = 1; data_in = 4'b1001;
        #10 load_en = 0;

        #90;

        $finish;
    end
endmodule
