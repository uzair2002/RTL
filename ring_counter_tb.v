module tb_ring_counter();

    reg clk, set_in;
    wire [3:0] count_out;

    ring_counter DUT (
        .clk(clk),
        .set_in(set_in),
        .count_out(count_out)
    );

    initial begin
        $dumpfile("ring_counter.vcd");
        $dumpvars(0,tb_ring_counter);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin
        $monitor("Time=%0t  |  set=%d  out=%d",
            $time, set_in, count_out);
    end

    initial begin
        set_in = 1; #10;
        set_in = 0; #50;
        set_in = 1; #10;
        set_in = 0; #40;
        $finish;
    end   

endmodule