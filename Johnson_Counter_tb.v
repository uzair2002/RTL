module tb_Johnson_Counter;
    reg reset_n,clk;
    wire [3:0] q_out;

    Johnson_Counter DUT (
        .reset_n(reset_n),
        .clk(clk),
        .q_out(q_out)
    );

    initial begin
        clk = 0;
        forever #5 clk =~clk;
    end

    initial begin
        $dumpfile("Johnson_Counter.vcd");
        $dumpvars(0,tb_Johnson_Counter);
    end

    initial begin
        $monitor("Time=%0t | reset_n=%b  clk=%b | q_out=%b",
            $time, reset_n,clk,q_out);
    end
    
    initial begin
        // Apply reset
        reset_n = 0;
        #12;

        // Release reset
        reset_n = 1;

        // Let it run for some cycles
        #100;

        // Apply reset again
        reset_n = 0;
        #10;

        // Release reset again
        reset_n = 1;
        #50;

        $finish;
    end

endmodule