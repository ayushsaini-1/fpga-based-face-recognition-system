`timescale 1ns/1ps

// Streaming RGB888 to grayscale/threshold preprocessing front-end.
// Connect the output stream to a resize or feature-extraction accelerator.
module face_preprocess #(
    parameter integer THRESHOLD = 8'd32
) (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        in_valid,
    input  wire        in_last,
    input  wire [7:0]  in_r,
    input  wire [7:0]  in_g,
    input  wire [7:0]  in_b,
    output reg         out_valid,
    output reg         out_last,
    output reg  [7:0]  out_gray,
    output reg         out_face_pixel
);
    // Integer approximation of Y = 0.299R + 0.587G + 0.114B.
    wire [17:0] weighted = (in_r * 18'd77) + (in_g * 18'd150) + (in_b * 18'd29);
    wire [7:0] gray_next = weighted[17:8];

    always @(posedge clk) begin
        if (!rst_n) begin
            out_valid      <= 1'b0;
            out_last       <= 1'b0;
            out_gray       <= 8'd0;
            out_face_pixel <= 1'b0;
        end else begin
            out_valid <= in_valid;
            out_last  <= in_valid && in_last;
            if (in_valid) begin
                out_gray       <= gray_next;
                out_face_pixel <= gray_next > THRESHOLD;
            end
        end
    end
endmodule
