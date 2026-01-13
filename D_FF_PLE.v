// D-FlpiFlop with positive level enable
module D_FF_PLE (D, LE, Q);
    input D,LE;
    output Q;
    reg Q;

    always @(D or LE) begin

        if (LE) begin
            Q <= D;
        end
        
    end

endmodule