module DownCounter_3bit(data_in, load_en, clk, reset_n, q_out);

    input [2:0] data_in;
    input load_en, clk, reset_n;
    output reg [2:0] q_out;

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) 
            q_out <= 3'b000;
        else if (load_en)
            q_out <= data_in;
        else
            q_out <= q_out - 1'b1;    
    end

endmodule