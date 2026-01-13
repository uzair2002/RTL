module tb_DownCounter_3bit();

    reg [2:0] data_in;
    reg load_en, clk, reset_n; 
    wire [2:0] q_out;

    DownCounter_3bit DUT (
        .data_in(data_in),
        .load_en(load_en), 
        .clk(clk), 
        .reset_n(reset_n),
        .q_out(q_out));

    initial begin
        $dumpfile("DownCounter_3bit.vcd");
        $dumpvars(0, tb_DownCounter_3bit);
    end

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time=%0t  |  load_en=%d  reset_n=%d  data_in=%d  |  q_out=%d  ",
            $time, load_en, reset_n, data_in, q_out);
    end


    // Stimulus
    initial begin

        // Step 1: Apply reset
        reset_n = 0; load_en = 0; data_in = 3'b000;
        #12 reset_n = 1; // Release reset

        // Step 2: Normal counting
        #20;

        // Step 3: Load data into counter
        load_en = 1; data_in = 3'b101; 
        #10 load_en = 0;

        // Step 4: Count again
        #30;

        // Step 5: Load again
        load_en = 1; data_in = 3'b011;
        #10 load_en = 0;

        // Step 6: More counting
        #30;

        // Step 7: Reset again
        reset_n = 0;
        #10 reset_n = 1;

        // Continue counting a bit more
        #30;

        $finish;
    end


endmodule