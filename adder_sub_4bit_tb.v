module tb_adder_sub_4bit;
    reg [3:0] A,B;
    reg Ci;
    wire [3:0] S;
    wire Co;

    adder_sub_4bit DUT (
        .A(A),
        .B(B),
        .Ci(Ci),
        .S(S),
        .Co(Co)    
    );

    initial begin
        $dumpfile("adder_sub_4bit.vcd");
        $dumpvars(0, tb_adder_sub_4bit);
    end

    initial begin 
        $monitor("Time=%0t  A=%b  B=%b  Ci=%b  |  S=%b  Co=%b",
        $time, A, B, Ci, S, Co);
    end

    initial begin
        A = 4'b0110; B = 4'b1001; Ci=0; #10;
        A = 4'b0110; B = 4'b1011; Ci=0; #10;
        A = 4'b0000; B = 4'b1001; Ci=0; #10;
        A = 4'b0000; B = 4'b0000; Ci=0; #10;
        A = 4'b0110; B = 4'b1111; Ci=0; #10;        
        A = 4'b0110; B = 4'b1001; Ci=1; #10;
        A = 4'b0110; B = 4'b1011; Ci=1; #10;
        A = 4'b0000; B = 4'b1001; Ci=1; #10;
        A = 4'b0000; B = 4'b0000; Ci=1; #10;
        A = 4'b0110; B = 4'b1111; Ci=1; #10;
        $finish;
    end
endmodule 
