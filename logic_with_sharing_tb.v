module tb_logic_with_sharing();

    reg a, b, c, d, e, f, s1, s2;
    wire x, y;

    logic_with_sharing DUT (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .x(x),
        .y(y)
    );

    initial begin
        $dumpfile("logic_with_sharing.vcd");
        $dumpvars(0, tb_logic_with_sharing);
    end

    initial begin
        $monitor("Time=%0t |  s1 = %d s2 = %d a = %d b = %d c = %d d = %d e = %d f = %d  |  x = %d y = %d",
                 $time,s1, s2, a, b, c, d, e, f, x, y);
    end


    initial begin
        #10 s1 =  0; s2 =  1; a =  0; b =  0; c =  0; d =  1; e =  1; f =  1;
        #10 s1 =  0; s2 =  1; a =  1; b =  0; c =  0; d =  0; e =  1; f =  0;
        #10 s1 =  0; s2 =  1; a =  0; b =  1; c =  0; d =  1; e =  0; f =  1;
        #10 s1 =  0; s2 =  1; a =  1; b =  1; c =  0; d =  0; e =  0; f =  0;
        #10 s1 =  1; s2 =  1; a =  0; b =  0; c =  1; d =  1; e =  0; f =  0;
        #10 s1 =  1; s2 =  1; a =  1; b =  0; c =  1; d =  0; e =  0; f =  1;
        #10 s1 =  1; s2 =  1; a =  0; b =  1; c =  1; d =  1; e =  0; f =  1;
        #10 s1 =  0; s2 =  0; a =  1; b =  1; c =  1; d =  0; e =  0; f =  1;
        #10 s1 =  0; s2 =  0; a =  0; b =  0; c =  0; d =  1; e =  1; f =  1;
        #10 s1 =  0; s2 =  0; a =  1; b =  0; c =  0; d =  0; e =  1; f =  1;

        #10 $finish;

    end

endmodule