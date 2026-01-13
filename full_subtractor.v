// this is the rtl code for full subtractor


module full_subtractor (a,b,c,d,bor);

    input a,b,c;
    output d,bor;
    reg [1:0] temp;

    always @ (a or b or c)
        begin
        temp = a-b-c;
        end

    assign d = temp[0];
    assign bor = temp[1];

endmodule
