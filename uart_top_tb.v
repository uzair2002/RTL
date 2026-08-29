`timescale 1ns/1ps

module uart_tb;

    // ============================================================
    // DUT signals
    // ============================================================

    reg clk = 0;
    reg rst = 0;
    reg rx = 1;

    reg [7:0] dintx = 0;
    reg newd = 0;

    wire tx;
    wire [7:0] doutrx;
    wire donetx;
    wire donerx;


    // ============================================================
    // DUT
    // ============================================================

uart_top #(1000000, 9600) dut
(
    clk,
    rst,
    rx,
    newd,
    dintx,
    tx,
    doutrx,
    donerx,
    donetx
);


    // ============================================================
    // 100 MHz? NO
    // 1 MHz clock
    // Period = 10 ns
    // ============================================================

    always #5 clk = ~clk;


    // ============================================================
    // Test variables
    // ============================================================

    reg [7:0] tx_data;
    reg [7:0] rx_data;

    integer i;
    integer j;


    // ============================================================
    // VCD generation
    // ============================================================

    initial begin
        $dumpfile("uart_top.vcd");
        $dumpvars(0, uart_tb);
    end


    // ============================================================
    // MAIN TEST
    // ============================================================

    initial begin

        // --------------------------------------------------------
        // Initial values
        // --------------------------------------------------------

        rst    = 1;
        rx     = 1;
        newd   = 0;
        dintx  = 8'h00;

        tx_data = 8'h00;
        rx_data = 8'h00;


        // --------------------------------------------------------
        // Reset
        // --------------------------------------------------------

        $display("");
        $display("======================================");
        $display("       UART SIMULATION START");
        $display("======================================");
        $display("");

        repeat(5) @(posedge clk);

        rst = 0;

        repeat(2) @(posedge dut.utx.uclk);


        // ========================================================
        // TX TEST
        // ========================================================

        $display("======================================");
        $display("             TX TEST");
        $display("======================================");

        for(i = 0; i < 5; i = i + 1)
        begin

            // Generate test byte
            dintx = $urandom_range(0,255);

            tx_data = dintx;

            $display("");
            $display("TX Test %0d", i+1);
            $display("Transmitting = %h (%b)",
                     tx_data,
                     tx_data);


            // Start transmission
            newd = 1;

            // Wait until START bit appears
            wait(tx == 0);

            // Stop new-data request
            newd = 0;


            // ----------------------------------------------------
            // Capture 8 transmitted data bits
            // ----------------------------------------------------

            @(posedge dut.utx.uclk);

            for(j = 0; j < 8; j = j + 1)
            begin
                @(posedge dut.utx.uclk);

                tx_data = {tx, tx_data[7:1]};
            end


            // Wait for transmission complete
            @(posedge donetx);

            $display("TX captured = %b",
                     tx_data);

        end


        // ========================================================
        // RX TEST
        // ========================================================

        $display("");
        $display("======================================");
        $display("             RX TEST");
        $display("======================================");

        for(i = 0; i < 5; i = i + 1)
        begin

            rx_data = $urandom_range(0,255);

            $display("");
            $display("RX Test %0d", i+1);
            $display("Sending to RX = %h (%b)",
                     rx_data,
                     rx_data);


            // ----------------------------------------------------
            // START BIT
            // ----------------------------------------------------

            rx = 1'b0;

            @(posedge dut.rtx.uclk);


            // ----------------------------------------------------
            // DATA BITS
            // LSB first
            // ----------------------------------------------------

            for(j = 0; j < 8; j = j + 1)
            begin

                rx = rx_data[j];

                @(posedge dut.rtx.uclk);

            end


            // ----------------------------------------------------
            // STOP BIT
            // ----------------------------------------------------

            rx = 1'b1;


            // Wait for RX completion
            @(posedge donerx);


            $display("RX received = %h (%b)",
                     doutrx,
                     doutrx);


            // ----------------------------------------------------
            // Compare
            // ----------------------------------------------------

            if(doutrx == rx_data)
            begin
                $display("RX RESULT : PASS");
            end
            else
            begin
                $display("RX RESULT : FAIL");
                $display("Expected  : %h", rx_data);
                $display("Received  : %h", doutrx);
            end

        end


        // ========================================================
        // END SIMULATION
        // ========================================================

        $display("");
        $display("======================================");
        $display("       UART SIMULATION FINISHED");
        $display("======================================");
        $display("");

        #100;

        $finish;

    end

endmodule