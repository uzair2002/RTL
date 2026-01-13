module tb_mux_2to1;

    reg A, B, S;
    wire Y;

    // Instantiate the DUT
    mux_2to1 DUT (
        .A(A),
        .B(B),
        .S(S),
        .Y(Y)
    );

    // VCD file generation
    initial begin
        $dumpfile("mux_2to1.vcd");
        $dumpvars(0, tb_mux_2to1);
    end

    // Monitor output whenever signals change
    initial begin
        $monitor("Time=%0t  A=%b  B=%b  S=%b  |  Y=%b",
                 $time, A, B, S, Y);
    end

    // Apply test vectors
    initial begin
        A = 0; B = 0; S = 0; #10;   // Expect Y = A = 0
        A = 0; B = 1; S = 0; #10;   // Expect Y = A = 0
        A = 1; B = 0; S = 0; #10;   // Expect Y = A = 1
        A = 1; B = 1; S = 0; #10;   // Expect Y = A = 1

        A = 0; B = 0; S = 1; #10;   // Expect Y = B = 0
        A = 0; B = 1; S = 1; #10;   // Expect Y = B = 1
        A = 1; B = 0; S = 1; #10;   // Expect Y = B = 0
        A = 1; B = 1; S = 1; #10;   // Expect Y = B = 1

        $finish;
    end

endmodule
