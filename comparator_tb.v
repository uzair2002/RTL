module tb_comparator;

    reg A, B;
    wire Y;

    comparator DUT (
        .A(A),
        .B(B),
        .Y(Y)
    );

    // Generate VCD file for waveform
    initial begin
        $dumpfile("comparator.vcd");
        $dumpvars(0, tb_comparator);
    end

    // Monitor values whenever they change
    initial begin
        $monitor("Time=%0t  A=%b  B=%b  |  Y=%b",
                  $time, A, B, Y);
    end

    // Apply all input combinations
    initial begin
        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;
        $finish;
    end

endmodule
