module ring_counter(clk, set_in, count_out);
    input clk, set_in;
    output reg [3:0] count_out;
    always @(posedge clk) begin
        if (set_in)
            count_out <= 4'b1000;
        else begin
            count_out <= (count_out<<1);
            count_out[0] <= count_out[3];
        end
    end
endmodule