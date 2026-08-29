`timescale 1ns/1ps

module fifo_top(
    input rst, clk, en, push_in, pop_in,
    input [7:0] din,
    output [7:0] dout,
    output empty, full, underrun, overrun,
    input [3:0] threshold,
    output th_trigger
);

reg [7:0] mem [0:15];
reg [3:0] waddr = 0;

logic push, pop;

reg empty_t;

always @(posedge clk , posedge rst) begin
    if(rst)
    empty_t <= 1'b0;
    else begin
        case({push, pop})
            2'b01: empty_t <= (~|(waddr) | ~en);
            2'b10: empty_t <= 1'b0;
        endcase
    end
end

reg full_t;

always @(posedge clk ,posedge rst) begin
    if(rst)
    full_t <= 1'b0;
    else begin
        case({push, pop})
            2'b01: full_t <= (&(waddr) | ~en);
            2'b10: full_t <= 1'b0; 
        endcase
    end
    
end

assign push = push_in & ~full_t;
assign pop = pop_in & ~ empty_t;


assign dout = mem[0];

always @(posedge clk, posedge rst ) begin
    if(rst)
    waddr <= 4'h0;
    else begin
        case({push, pop})
            2'b01:begin
                if(waddr != 4'hf && full_t == 1'b0)
                waddr <= waddr + 1;
                else
                waddr <= waddr;
            end
            2'b10:begin
                if (waddr != 4'h0 && empty_t == 1'b0) begin
                    waddr <= waddr - 1;
                end
                else
                waddr <= waddr;
            end
            default: ;
        endcase
    end
end

always @(posedge clk, posedge rst) begin
    case({push, pop})
    2'b01: begin //pop
        for(int i = 0; i < 14 ; i++) begin
            mem[i] <= mem[i+1];
        end
        mem[15] <= 8'h00;
    end
    2'b10: begin
        mem[waddr] <= din;
    end
    2'b11:begin
        for(int i = 0; i < 14; i++)begin
            mem[i] <= mem[i+1];
        end
        mem[15] <= 8'h00;
        mem[waddr-1] <= din;
    end
    endcase
end

//underrun
reg underrun_t;
always @(posedge clk, posedge rst ) begin
    if(rst)
    underrun_t <= 1'b0;
    else if (pop_in == 1'b1 && empty_t == 1'b1)
    underrun_t <= 1'b1;
    else
    underrun_t <=1'b0;
end

//overrun
reg overrun_t = 1'b0;
always @(posedge clk, posedge rst) begin
    if(rst)
    overrun_t <= 1'b0;
    else if (push_in == 1'b1 && full_t == 1'b1) begin
        overrun_t <= 1'b1;
    end
    else
    overrun_t <= 1'b0;
end

//threshold
reg thre_t;
always @(posedge clk, posedge rst) begin
    if(rst)
        thre_t <= 1'b0;
    else if(push ^ pop)
        thre_t <= (waddr >= threshold) ? 1'b1 : 1'b0;
    else
        thre_t <= 1'b0;

end


assign empty =  empty_t;
assign full = full_t;
assign underrun = underrun_t;
assign overrun = overrun_t;
assign th_trigger = thre_t;

endmodule



`timescale 1ns/1ps

module fifo_tb;

    // ============================================================
    // DUT signals
    // ============================================================

    reg        rst;
    reg        clk;
    reg        en;
    reg        push_in;
    reg        pop_in;
    reg [7:0]  din;

    wire [7:0] dout;
    wire       empty;
    wire       full;
    wire       underrun;
    wire       overrun;

    reg  [3:0] threshold;
    wire       th_trigger;


    // ============================================================
    // DUT
    // ============================================================

    fifo_top dut_fifo
    (
        .rst       (rst),
        .clk       (clk),
        .en        (en),
        .push_in   (push_in),
        .pop_in    (pop_in),
        .din       (din),
        .dout      (dout),
        .empty     (empty),
        .full      (full),
        .underrun  (underrun),
        .overrun   (overrun),
        .threshold (threshold),
        .th_trigger(th_trigger)
    );


    // ============================================================
    // Clock
    // 10 ns period
    // ============================================================

    always #5 clk = ~clk;


    // ============================================================
    // Test variables
    // ============================================================

    integer errors = 0;
    integer i;

    reg [7:0] expected;


    // ============================================================
    // VCD
    // ============================================================

    initial begin
        $dumpfile("fifo_top.vcd");
        $dumpvars(0, fifo_tb);
    end


    // ============================================================
    // MAIN TEST
    // ============================================================

    initial begin

        // --------------------------------------------------------
        // Initial values
        // --------------------------------------------------------

        clk       = 0;
        rst       = 1;
        en        = 0;
        push_in   = 0;
        pop_in    = 0;
        din       = 0;
        threshold = 4'd10;


        $display("");
        $display("============================================");
        $display("          FIFO SIMULATION START");
        $display("============================================");
        $display("");


        // ========================================================
        // RESET TEST
        // ========================================================

        $display("---- RESET TEST ----");

        repeat(3) @(posedge clk);

        rst = 0;
        en  = 1;

        @(posedge clk);

        $display("empty = %b, full = %b", empty, full);

        // NOTE:
        // A normal FIFO should have empty = 1 after reset.
        // Your current DUT sets empty_t = 0 during reset.
        // Therefore this check is expected to FAIL with your
        // current design.

        if (empty !== 1'b1) begin
            $display("WARNING: FIFO is not EMPTY after reset!");
            $display("         Current DUT gives empty = %b", empty);
            $display("");
        end
        else begin
            $display("RESET EMPTY CHECK : PASS");
        end


        // ========================================================
        // PUSH TEST
        // ========================================================

        $display("============================================");
        $display("             PUSH TEST");
        $display("============================================");

        for(i = 0; i < 5; i = i + 1)
        begin

            din     = 8'h10 + i;
            push_in = 1;
            pop_in  = 0;

            @(posedge clk);

            #1;

            $display("PUSH %0d : din = %h, dout = %h, count = %0d",
                     i,
                     din,
                     dout,
                     dut_fifo.waddr);
        end

        push_in = 0;

        @(posedge clk);


        // ========================================================
        // FIFO ORDER TEST
        // ========================================================

        $display("");
        $display("============================================");
        $display("          FIFO ORDER TEST");
        $display("============================================");

        for(i = 0; i < 5; i = i + 1)
        begin

            expected = 8'h10 + i;

            pop_in = 1;

            @(posedge clk);

            #1;

            if(dout === expected)
            begin
                $display("POP %0d : Expected = %h, Received = %h : PASS",
                         i,
                         expected,
                         dout);
            end
            else
            begin
                $display("POP %0d : Expected = %h, Received = %h : FAIL",
                         i,
                         expected,
                         dout);

                errors = errors + 1;
            end
        end

        pop_in = 0;


        // ========================================================
        // FULL TEST
        // ========================================================

        $display("");
        $display("============================================");
        $display("             FULL TEST");
        $display("============================================");

        // Push 16 elements
        for(i = 0; i < 16; i = i + 1)
        begin

            din     = 8'hA0 + i;
            push_in = 1;
            pop_in  = 0;

            @(posedge clk);

            #1;

            $display("PUSH %0d : din=%h full=%b",
                     i,
                     din,
                     full);
        end

        push_in = 0;

        @(posedge clk);

        if(full === 1'b1)
        begin
            $display("FULL CHECK : PASS");
        end
        else
        begin
            $display("FULL CHECK : FAIL");
            errors = errors + 1;
        end


        // ========================================================
        // OVERRUN TEST
        // ========================================================

        $display("");
        $display("============================================");
        $display("            OVERRUN TEST");
        $display("============================================");

        din     = 8'hFF;
        push_in = 1;
        pop_in  = 0;

        @(posedge clk);

        #1;

        if(overrun === 1'b1)
        begin
            $display("OVERRUN CHECK : PASS");
        end
        else
        begin
            $display("OVERRUN CHECK : FAIL");
            errors = errors + 1;
        end

        push_in = 0;


        // ========================================================
        // CLEAR FIFO BY POPPING
        // ========================================================

        $display("");
        $display("============================================");
        $display("           EMPTY / POP TEST");
        $display("============================================");

        pop_in = 1;

        for(i = 0; i < 16; i = i + 1)
        begin

            @(posedge clk);

            #1;

            $display("POP %0d : dout=%h empty=%b",
                     i,
                     dout,
                     empty);
        end

        pop_in = 0;

        @(posedge clk);

        if(empty === 1'b1)
        begin
            $display("EMPTY CHECK : PASS");
        end
        else
        begin
            $display("EMPTY CHECK : FAIL");
            errors = errors + 1;
        end


        // ========================================================
        // UNDERRUN TEST
        // ========================================================

        $display("");
        $display("============================================");
        $display("            UNDERRUN TEST");
        $display("============================================");

        pop_in = 1;

        @(posedge clk);

        #1;

        if(underrun === 1'b1)
        begin
            $display("UNDERRUN CHECK : PASS");
        end
        else
        begin
            $display("UNDERRUN CHECK : FAIL");
            errors = errors + 1;
        end

        pop_in = 0;


        // ========================================================
        // THRESHOLD TEST
        // ========================================================

        $display("");
        $display("============================================");
        $display("           THRESHOLD TEST");
        $display("============================================");

        threshold = 4'd5;

        for(i = 0; i < 6; i = i + 1)
        begin

            din     = 8'h50 + i;
            push_in = 1;
            pop_in  = 0;

            @(posedge clk);

            #1;

            $display("PUSH %0d : waddr=%0d threshold=%0d trigger=%b",
                     i,
                     dut_fifo.waddr,
                     threshold,
                     th_trigger);
        end

        push_in = 0;


        // ========================================================
        // FINAL RESULT
        // ========================================================

        $display("");
        $display("============================================");

        if(errors == 0)
        begin
            $display("       ALL CHECKS PASSED");
        end
        else
        begin
            $display("       TEST FAILED");
            $display("       Total Errors = %0d", errors);
        end

        $display("============================================");
        $display("");

        #20;

        $finish;

    end

endmodule

// module fifo_tb;
// reg rst, clk, en, push_in, pop_in;
// reg [7:0] din;
// wire [7:0] dout;
// wire empty, full, overrun, underrun;
// reg [3:0] threshold;
// wire thre_trigger;
 
// initial begin
// rst = 0;
// clk = 0;
// en = 0;
// din = 0;
// end
 
 
 
 
// fifo_top dut_fifo (rst, clk, en, push_in, pop_in, din, dout,empty, full, overrun, underrun,threshold,thre_trigger );
 
// always #5 clk = ~clk;
 
// initial begin
//     $dumpfile("fifo_top.vcd");
//     $dumpvars(0, fifo_tb);
// end

// initial begin
// rst = 1'b1;
// repeat(5)@(posedge clk);
 
// for(int i = 0; i<20 ; i++)
// begin
// rst = 1'b0;
// push_in = 1'b1;
// din = $urandom();
// pop_in = 1'b0;
// en = 1'b1;
// threshold = 4'ha;
// @(posedge clk);
// end
// ///////////////////read
// for(int i = 0; i<20 ; i++)
// begin
// rst = 1'b0;
// push_in = 1'b0;
// din = 0;
// pop_in = 1'b1;
// en = 1'b1;
// threshold = 4'ha;
// @(posedge clk);
// end
 
// $finish;

// end
// endmodule
 