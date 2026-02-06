module parameterizedCounter (data_in, load_en, clk, reset_n, count_out);
    parameter N= 8;
    input reset_n, clk, load_en;
    input [N-1:0] data_in;
    output reg [N-1:0] count_out;
    always @(posedge clk) begin
        if(~reset_n)
        count_out<=0;
        else if(load_en)
        count_out<=data_in;
        else
        count_out<=count_out+1'b1;
    end
endmodule