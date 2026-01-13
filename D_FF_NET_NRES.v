// this code is for D flip flip which is negative edge triggered with reset
module D_FF_NET_NRES(d_in, clk, n_res, q_out);

    input d_in, clk, n_res;
    output reg  q_out;


    always @(posedge clk or negedge n_res) begin

        if (~n_res)
            q_out <= 1'b0;
        else
            q_out <= d_in;
        
    end

endmodule