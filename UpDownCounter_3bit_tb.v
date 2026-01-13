module tb_UpDownCounter_3bit();

    reg [2:0] data_in;
    reg up_down, load_en,clk,reset_n;
    wire [2:0] q_out;

    UpDownCounter_3bit DUT (
        .up_down(up_down), 
        .data_in(data_in), 
        .load_en(load_en), 
        .clk(clk), 
        .reset_n(reset_n), 
        .q_out(q_out)
    );


    initial begin
        $dumpfile("UpDownCounter_3bit.vcd");
        $dumpvars(0,tb_UpDownCounter_3bit);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time=%0t  |  up_down=%d  data_in=%d  load_en=%d  reset_n=%d  q_out=%d  ",
        $time, up_down, data_in, load_en, reset_n, q_out);
    end

    initial begin
        // initial values
        reset_n = 0; up_down = 1; load_en = 0; data_in = 3'b000; #12;

        // release reset
        reset_n = 1; #10;

        // count up for a few cycles
        up_down = 1; load_en = 0; #60;

        // load a value
        data_in = 3'b101; load_en = 1; #10;
        load_en = 0; #10;

        // count up more
        up_down = 1; #30;

        // load another value
        data_in = 3'b010; load_en = 1; #10;
        load_en = 0; #10;

        // now count down
        up_down = 0; #50;

        // reset again mid-way
        reset_n = 0; #10;
        reset_n = 1; #10;

        // count down after reset
        up_down = 0; #40;

        $finish;
    end

endmodule