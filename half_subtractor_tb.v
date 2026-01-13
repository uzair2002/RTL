//=========================================
// Testbench for Half Subtractor (with VCD)
//=========================================

module tb_half_subtractor;

    // Testbench signals
    reg a;
    reg b;
    wire d;
    wire bor;

    // Instantiate the Design Under Test (DUT)
    half_subtractor DUT (
        .a(a),
        .b(b),
        .d(d),
        .bor(bor)
    );

    // VCD file generation
    initial begin
        $dumpfile("half_subtractor.vcd"); // Output VCD file
        $dumpvars(0, tb_half_subtractor); // Dump all signals in this module
    end

    // Apply inputs
    initial begin
        $display("A  B | D  BOR");
        $display("----------------");

        // Test case 1
        a = 0; b = 0;
        #10 $display("%b  %b | %b   %b", a, b, d, bor);

        // Test case 2
        a = 0; b = 1;
        #10 $display("%b  %b | %b   %b", a, b, d, bor);

        // Test case 3
        a = 1; b = 0;
        #10 $display("%b  %b | %b   %b", a, b, d, bor);

        // Test case 4
        a = 1; b = 1;
        #10 $display("%b  %b | %b   %b", a, b, d, bor);

        $finish;
    end

endmodule
