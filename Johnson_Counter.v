module Johnson_Counter(reset_n,clk,q_out);

    input reset_n,clk;
    output reg [3:0] q_out;

    always @(posedge clk or negedge reset_n) begin
        if(~reset_n)
            q_out <= 4'b0000;
        else
            q_out <= {{q_out[2:0]},{~q_out[3]}};
    end
endmodule