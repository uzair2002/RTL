module tb_D_FF_PLE ();
    reg D, LE;
    wire Q;

    D_FF_PLE DUT (
        .D(D),
        .LE(LE),
        .Q(Q)
    ); 

    initial begin
        $dumpfile("D_FF_PLE.vcd");
        $dumpvars(0, tb_D_FF_PLE);
    end

    initial begin
        $monitor("Time = %0t LE = %d  D = %d  |  Q = %d",
            $time, LE, D, Q);
    end

    initial begin
        #10;
        #10; LE = 0; D = 0;
        #10; LE = 1; D = 0;
        #10; LE = 1; D = 1;
        #10; LE = 1; D = 0;
        #10; LE = 1; D = 1;
        #10; LE = 0; D = 0;
        #10; LE = 0; D = 1;
        #10; LE = 1; D = 0;
        #10 $finish;
        
    end

endmodule