module tb_decoder_3to8;

    reg  [2:0] X;
    reg        En;
    wire [7:0] Y;

    // Instantiate DUT
    decoder_3to8 DUT (
        .X(X),
        .En(En),
        .Y(Y)
    );

    // VCD dump
    initial begin
        $dumpfile("decoder_3to8.vcd");
        $dumpvars(0, tb_decoder_3to8);
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t  X=%b  En=%b  |  Y=%b", 
                  $time, X, En, Y);
    end

    // Apply test patterns
    initial begin
        En = 1;

        X = 3'b000; #10;
        X = 3'b001; #10;
        X = 3'b010; #10;
        X = 3'b011; #10;
        X = 3'b100; #10;
        X = 3'b101; #10;
        X = 3'b110; #10;
        X = 3'b111; #10;

        // Disable decoder
        En = 0;  X = 3'b101; #10;

        $finish;
    end

endmodule
