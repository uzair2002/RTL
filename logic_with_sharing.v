module logic_with_sharing(a, b, c, d, e, f, s1, s2, x, y);

    input a, b, c, d, e, f, s1, s2;
    output x, y;
    reg x, y; 
    reg temp1, temp2, temp3, temp4;

    always @(a or b or c or d or s1)
    begin
        if (s1)
        begin
            temp1 = a;
            temp2 = b;
        end
        else
        begin
            temp1 = c;
            temp2 = d; 
        end
    end

    always @(e or f or a or b or s2)
    begin
        if (s2) begin
            temp3 = e;
            temp4 = f;
        end
        else begin
            temp3 = a;
            temp4 = b;
        end
    end

    always @(temp1 or temp2 or temp3 or temp4) begin
        x = temp1 + temp2;
        y = temp3 + temp4;
    end

endmodule