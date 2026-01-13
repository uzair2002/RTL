// This is the testbench for full subtractor that generates the VCD file

module tb_full_subtractor;

    reg a;
    reg b;
    reg c;     // borrow in
    wire d;    // difference
    wire bor;  // borrow out

    full_subtractor DUT (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .bor(bor)
    );  // <-- missing semicolon fixed

    // VCD dump
    initial begin
        $dumpfile("full_subtractor.vcd");
        $dumpvars(0, tb_full_subtractor); // corrected dumpvars
    end

    // Monitor output continuously
    initial begin
        $monitor("Time=%0t  A=%b  B=%b  C=%b | D=%b  BOR=%b", 
                  $time, a, b, c, d, bor);
    end

    // Apply input combinations
    initial begin
        a = 0; b = 0; c = 0; #10;
        a = 0; b = 1; c = 0; #10;
        a = 1; b = 0; c = 0; #10;
        a = 1; b = 1; c = 0; #10;

        a = 0; b = 0; c = 1; #10;
        a = 0; b = 1; c = 1; #10;
        a = 1; b = 0; c = 1; #10;
        a = 1; b = 1; c = 1; #10;

        $finish;
    end

endmodule
