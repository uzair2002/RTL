module adder_sub_4bit (A,B,Ci,S,Co);

parameter data_size = 4;
input [data_size-1:0] A,B;
input Ci;
output [data_size-1:0] S;
output Co;
reg [data_size-1:0] S;
reg Co;

always @ (A or B or Ci)
    if (Ci)
        {Co,S} = A - B;
    else
        {Co,S} = A + B;
endmodule