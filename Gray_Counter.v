module Gray_Counter(clk, reset, data_in, load_en, out);

    input clk, reset;
    input load_en;
    input [3:0] data_in;
    
    output reg [3:0] out;
    reg q0, q1, q2;
    reg [3:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0;
            {q2,q1,q0} <= 3'b000;
            out <= 4'b0;
        end
        
        else if (load_en) begin
            count <= data_in;
            {q2, q1, q0} <= {data_in[2], data_in[1], data_in[0]};
            out <= {data_in[3], data_in[2], data_in[1], data_in[0]};
        end
        else begin
            count <= count + 1'b1;
            q2 <= count[3] ^ count[2];
            q1 <= count[2] ^ count[1];
            q0 <= count[1] ^ count[0];
            out <= {count[3],q2,q1,q0};

        end

    end
endmodule