module comparator (A,B,Y);
    input A,B;
    output Y;

    reg Y;

    always @ (A or B)
    begin
        if (A==B)
            Y = A ^ B;   // XOR of two equal bits → always 0
        else
            Y = A & B;   // AND of different bits → always 0
    end
endmodule
