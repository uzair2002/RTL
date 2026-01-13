module Gray_Counter2 #(parameter size = 4)

    (output reg [size-1:0] gray,
    input wire clk, full, inc, reset_n);

    reg [size-1:0] bin;
    wire [size-1:0] gnext, bnext;

    always @(posedge clk or negedge reset_n)
        if(!reset_n)
            {bin,gray} <= 2'b00;

        else
            {bin,gray}<={bnext,gnext};
        

    assign bnext = !full ? bin+inc : bin;
    assign gnext = (bnext>>1)^bnext;

endmodule