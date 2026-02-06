<<<<<<< HEAD
module parameterizedCounter_tb ();
    parameter N = 8;
    reg clk, load_en, reset_n;
    reg [N-1:0] data_in;
    wire [N-1:0] count_out;

    parameterizedCounter DUT(
        .clk(clk),
        .data_in(data_in),
        .load_en(load_en),
        .reset_n(reset_n),
        .count_out(count_out)
    );

    // clock: 10 time-unit period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("parameterizedCounter.vcd");
        $dumpvars(0, parameterizedCounter_tb);
    end

    initial begin
        $monitor("Time=%0t | reset_n=%b load_en=%b data_in=%b | count_out=%b",
                 $time, reset_n, load_en, data_in, count_out);
    end

    initial begin
        // -----------------------
        // Init
        // -----------------------
        reset_n = 1'b0;
        load_en = 1'b0;
        data_in = {N{1'b0}};

        // Hold reset for 2 clock cycles
        @(posedge clk);
        @(posedge clk);
        reset_n = 1'b1;

        // -----------------------
        // Test 1: Normal counting
        // -----------------------
        repeat(6) @(posedge clk);

        // -----------------------
        // Test 2: Load zero
        // -----------------------
        load_en = 1'b1;
        data_in = 8'b0000_0000;
        @(posedge clk);          // load happens here
        load_en = 1'b0;

        repeat(4) @(posedge clk);

        // -----------------------
        // Test 3: Load 0x38
        // -----------------------
        load_en = 1'b1;
        data_in = 8'b0011_1000;  // 0x38
        @(posedge clk);          // load happens here
        load_en = 1'b0;

        repeat(5) @(posedge clk);

        // -----------------------
        // Test 4 (NEW): Load max value 0xFF and check overflow wrap
        // -----------------------
        load_en = 1'b1;
        data_in = 8'b1111_1111;  // 0xFF
        @(posedge clk);          // load happens here
        load_en = 1'b0;

        // after increment -> should wrap (FF + 1 = 00)
        repeat(3) @(posedge clk);

        // -----------------------
        // Test 5 (NEW): Reset in middle of counting
        // -----------------------
        reset_n = 1'b0;
        @(posedge clk);
        @(posedge clk);
        reset_n = 1'b1;

        repeat(4) @(posedge clk);

        $finish;
    end

endmodule
=======
module parameterizedCounter_tb ();
    parameter N = 8;
    reg clk, load_en, reset_n;
    reg [N-1:0] data_in;
    wire [N-1:0] count_out;

    parameterizedCounter DUT(
        .clk(clk),
        .data_in(data_in),
        .load_en(load_en),
        .reset_n(reset_n),
        .count_out(count_out)
    );

    // clock: 10 time-unit period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("parameterizedCounter.vcd");
        $dumpvars(0, parameterizedCounter_tb);
    end

    initial begin
        $monitor("Time=%0t | reset_n=%b load_en=%b data_in=%b | count_out=%b",
                 $time, reset_n, load_en, data_in, count_out);
    end

    initial begin
        // -----------------------
        // Init
        // -----------------------
        reset_n = 1'b0;
        load_en = 1'b0;
        data_in = {N{1'b0}};

        // Hold reset for 2 clock cycles
        @(posedge clk);
        @(posedge clk);
        reset_n = 1'b1;

        // -----------------------
        // Test 1: Normal counting
        // -----------------------
        repeat(6) @(posedge clk);

        // -----------------------
        // Test 2: Load zero
        // -----------------------
        load_en = 1'b1;
        data_in = 8'b0000_0000;
        @(posedge clk);          // load happens here
        load_en = 1'b0;

        repeat(4) @(posedge clk);

        // -----------------------
        // Test 3: Load 0x38
        // -----------------------
        load_en = 1'b1;
        data_in = 8'b0011_1000;  // 0x38
        @(posedge clk);          // load happens here
        load_en = 1'b0;

        repeat(5) @(posedge clk);

        // -----------------------
        // Test 4 (NEW): Load max value 0xFF and check overflow wrap
        // -----------------------
        load_en = 1'b1;
        data_in = 8'b1111_1111;  // 0xFF
        @(posedge clk);          // load happens here
        load_en = 1'b0;

        // after increment -> should wrap (FF + 1 = 00)
        repeat(3) @(posedge clk);

        // -----------------------
        // Test 5 (NEW): Reset in middle of counting
        // -----------------------
        reset_n = 1'b0;
        @(posedge clk);
        @(posedge clk);
        reset_n = 1'b1;

        repeat(4) @(posedge clk);

        $finish;
    end

endmodule
>>>>>>> e302a95bb10e9f649982298a248b87360d5fa7a7
