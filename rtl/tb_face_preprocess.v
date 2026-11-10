`timescale 1ns/1ps
module tb_face_preprocess;
    reg clk = 0;
    always #5 clk = ~clk;
    reg rst_n = 0, in_valid = 0, in_last = 0;
    reg [7:0] in_r = 0, in_g = 0, in_b = 0;
    wire out_valid, out_last, out_face_pixel;
    wire [7:0] out_gray;

    face_preprocess dut (.*);

    initial begin
        $dumpfile("face_preprocess.vcd");
        $dumpvars(0, tb_face_preprocess);
        repeat (2) @(posedge clk);
        rst_n <= 1;
        @(posedge clk); in_valid <= 1; in_last <= 0; in_r <= 8'd255; in_g <= 0; in_b <= 0;
        @(posedge clk); in_last <= 1; in_r <= 0; in_g <= 8'd255; in_b <= 0;
        @(posedge clk); in_valid <= 0; in_last <= 0;
        repeat (2) @(posedge clk);
        $finish;
    end

    always @(posedge clk)
        if (out_valid) $display("gray=%0d face_pixel=%0d last=%0d", out_gray, out_face_pixel, out_last);
endmodule
