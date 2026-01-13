module tb_full_adder_4_bit;
    reg [3:0] a,b;
    reg ci;
    wire [3:0] s;
    wire co;

    full_adder_4_bit DUT (
        .a(a),
        .b(b),
        .ci(ci),
        .s(s),
        .co(co)
    );

    initial begin
        $dumpfile("full_adder_4_bit.vcd");
        $dumpvars(0, tb_full_adder_4_bit);
    end

    initial begin
        $monitor("Time=%0t  A=%b  B=%b  Ci=%b  |  S=%b  Co=%b",
        $time, a, b, ci, s, co);
    end

    initial begin
        a = 4'b0110; b = 4'b1001; ci=0; #10;
        a = 4'b0110; b = 4'b1011; ci=0; #10;
        a = 4'b0000; b = 4'b1001; ci=0; #10;
        a = 4'b0000; b = 4'b0000; ci=0; #10;
        a = 4'b0110; b = 4'b1111; ci=0; #10;
        $finish;
    end
endmodule
