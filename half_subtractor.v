module half_subtractor (a,b,d,bor);
input a;
input b;
output d;
output bor;
wire d;
wire bar;
assign d = a ^ b;
assign bar = (~a & b);
endmodule