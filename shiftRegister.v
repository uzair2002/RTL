module shiftRegister (data_in,clk,reset_n,data_out);

    input data_in, clk, reset_n;
    output reg data_out;
    reg temp1_out,temp2_out,temp3_out;

    always @(posedge clk or negedge reset_n) begin

        if (~reset_n) begin
            data_out<=1'b0;
            temp1_out<=1'b0;
            temp2_out<=1'b0;
            temp3_out<=1'b0;
        end
        else begin
            temp1_out<=data_in;
            temp2_out<=temp1_out;
            temp3_out<=temp2_out;
            data_out<=temp3_out;
        end
        
    end
    
endmodule