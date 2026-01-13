//synchronous up down counter

module UpDownCounter_3bit(up_down, data_in, load_en, clk, reset_n, q_out);

    input [2:0] data_in;
    input up_down, load_en,clk,reset_n;
    output reg [2:0] q_out;

    always @(posedge clk or reset_n) begin
        if (~reset_n)
            q_out <= 3'b000;
        else if (load_en)
            q_out <= data_in;
        else

            if(up_down)
                q_out <= q_out+1'b1;
            else
                q_out <= q_out-1'b1;
    end

endmodule