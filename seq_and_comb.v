//==========================================================
// Sequential + Combinational Example
//==========================================================

module seq_and_comb (
    input        clk,        // clock
    input        data_in,    // input to D-FF
    output reg   q_out,      // sequential output
    input        a_in,       // input A for MUX
    input        b_in,       // input B for MUX
    input        sel_in,     // select line
    output reg   y_out       // MUX output
);

    // ----------------------------
    // Sequential Logic (D Flip-Flop)
    // ----------------------------
    always @(posedge clk)
    begin
        q_out <= data_in;   // non-blocking assignment
    end

    // ----------------------------
    // Combinational Logic (2:1 MUX)
    // ----------------------------
    always @ (a_in or b_in or sel_in)
    begin
        y_out = sel_in ? a_in : b_in;   // blocking assignment
    end

endmodule
