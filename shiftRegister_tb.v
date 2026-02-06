<<<<<<< HEAD
module tb_shiftRegister ();
    reg data_in, clk, reset_n;
    wire data_out;

    shiftRegister DUT (
        .data_in(data_in),
        .clk(clk),
        .reset_n(reset_n),
        .data_out(data_out)
    );
    
    initial begin
        $dumpfile("shiftRegister.vcd");
        $dumpvars(0,tb_shiftRegister);
        $dumpvars(0, DUT);

    end 

    initial begin
        clk=0;
        forever #5 clk=~clk;
    end

    initial begin
        $monitor("Time=%0t  reset_n=%b  data_in=%b  temp1_out=%b  temp2_out=%b  temp3_out=%b  data_out=%b",
        $time, reset_n, data_in, DUT.temp1_out, DUT.temp2_out, DUT.temp3_out, data_out);
    end

    initial begin
        data_in = 0;
        reset_n = 0;

        // hold reset for 2 posedges
        @(posedge clk);
        @(posedge clk);
        reset_n = 1;

        // shift in bits
        data_in = 1; @(posedge clk);
        data_in = 0; @(posedge clk);
        data_in = 1; @(posedge clk);
        data_in = 1; @(posedge clk);
        data_in = 0; @(posedge clk);

        #10 $finish;
    end
=======
module tb_shiftRegister ();
    reg data_in, clk, reset_n;
    wire data_out;

    shiftRegister DUT (
        .data_in(data_in),
        .clk(clk),
        .reset_n(reset_n),
        .data_out(data_out)
    );
    
    initial begin
        $dumpfile("shiftRegister.vcd");
        $dumpvars(0,tb_shiftRegister);
        $dumpvars(0, DUT);

    end 

    initial begin
        clk=0;
        forever #5 clk=~clk;
    end

    initial begin
        $monitor("Time=%0t  reset_n=%b  data_in=%b  temp1_out=%b  temp2_out=%b  temp3_out=%b  data_out=%b",
        $time, reset_n, data_in, DUT.temp1_out, DUT.temp2_out, DUT.temp3_out, data_out);
    end

    initial begin
        data_in = 0;
        reset_n = 0;

        // hold reset for 2 posedges
        @(posedge clk);
        @(posedge clk);
        reset_n = 1;

        // shift in bits
        data_in = 1; @(posedge clk);
        data_in = 0; @(posedge clk);
        data_in = 1; @(posedge clk);
        data_in = 1; @(posedge clk);
        data_in = 0; @(posedge clk);

        #10 $finish;
    end
>>>>>>> e302a95bb10e9f649982298a248b87360d5fa7a7
endmodule