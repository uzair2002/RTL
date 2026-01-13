module full_adder_4_bit (a,b,ci,s,co);
    parameter data_size = 4;
    input [data_size-1:0] a;
    input [data_size-1:0] b;
    input ci;
    output [data_size-1:0] s;
    output co;

    assign{co,s} = a + b + ci;
endmodule