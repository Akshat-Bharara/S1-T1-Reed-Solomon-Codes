// S1-T1-Reed-Solomon-Codes
// Data Recovery and Error Correction in Space Communication

// Behvaioural level model

// Member-1: Akshat Bharara, Roll No: 231CS110
// Member-2: Dev Prajapati, Roll No: 231CS120
// Member-3: Vatsal Jay Gandhi, Roll No: 231CS164

module encypt_vigenere_cipher (
    input [3:0] key, // 4-bit key
    input [3:0] data_in0,
    input [3:0] data_in1,
    input [3:0] data_in2,
    input [3:0] data_in3,
    input [3:0] data_in4,
    input [3:0] data_in5,
    input [3:0] data_in6,
    input [3:0] data_in7,
    output reg [3:0] data_out0,
    output reg [3:0] data_out1,
    output reg [3:0] data_out2,
    output reg [3:0] data_out3,
    output reg [3:0] data_out4,
    output reg [3:0] data_out5,
    output reg [3:0] data_out6,
    output reg [3:0] data_out7
);

always @(*) begin
    data_out0 = (data_in0 + key) % 8; 
    data_out1 = (data_in1 + key) % 8;
    data_out2 = (data_in2 + key) % 8;
    data_out3 = (data_in3 + key) % 8;
    data_out4 = (data_in4 + key) % 8;
    data_out5 = (data_in5 + key) % 8;
    data_out6 = (data_in6 + key) % 8;
    data_out7 = (data_in7 + key) % 8;
end

endmodule


module lagrange_interpolation(
    input [3:0] x_input, // Input x (0 to 15)
    input [15:0] y1,
    input [15:0] y2,
    input [15:0] y3,
    input [15:0] y4,
    input [15:0] y5,
    input [15:0] y6,
    input [15:0] y7,
    input [15:0] y8,
    output reg [15:0] y_output // Output y
);
    // Fixed x-coordinates
    parameter [3:0] x1 = 4'd1, x2 = 4'd2, x3 = 4'd3, x4 = 4'd4;
    parameter [3:0] x5 = 4'd5, x6 = 4'd6, x7 = 4'd7, x8 = 4'd8;

    // Declare temporary variables for each term
    reg signed [63:0] numerator, denominator;
    real result1, result2, result3, result4, result5, result6, result7, result8;
    real final_result;
    
    // Scaling factor for fixed-point arithmetic
    integer scaling_factor = 100000;
    reg signed [63:0] scaled_result;
    real intermediate_result;
    always @(*) begin
        // Initialize output and sum
        y_output = 16'd0;
        final_result = 0.0;


        // Calculate numerator and denominator separately for each term
        numerator = ((x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x1 - x2) * (x1 - x3) * (x1 - x4) * (x1 - x5) * (x1 - x6) * (x1 - x7) * (x1 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            //$display("Scaled result is : %d",scaled_result);
            result1 = scaled_result / 100000.0;
        end else begin
            result1 = 0.0;
        end
        //$display("Numerator for y1: %d", numerator);
        //$display("Denominator for y1: %d", denominator);
        //$display("Result 1: %f", result1 * y1);

        numerator = ((x_input - x1) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x2 - x1) * (x2 - x3) * (x2 - x4) * (x2 - x5) * (x2 - x6) * (x2 - x7) * (x2 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result2 = scaled_result / 100000.0;
        end else begin
            result2 = 0.0;
        end
        //$display("Numerator for y2: %d", numerator);
        //$display("Denominator for y2: %d", denominator);
        //$display("Result 2: %f", result2 * y2);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x3 - x1) * (x3 - x2) * (x3 - x4) * (x3 - x5) * (x3 - x6) * (x3 - x7) * (x3 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result3 = scaled_result / 100000.0;
        end else begin
            result3 = 0.0;
        end
        //$display("Numerator for y3: %d", numerator);
        //$display("Denominator for y3: %d", denominator);
        //$display("Result 3: %f", result3 * y3);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x4 - x1) * (x4 - x2) * (x4 - x3) * (x4 - x5) * (x4 - x6) * (x4 - x7) * (x4 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result4 = scaled_result / 100000.0;
        end else begin
            result4 = 0.0;
        end
        //$display("Numerator for y4: %d", numerator);
        //$display("Denominator for y4: %d", denominator);
        //$display("Result 4: %f", result4 * y4);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x5 - x1) * (x5 - x2) * (x5 - x3) * (x5 - x4) * (x5 - x6) * (x5 - x7) * (x5 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result5 = scaled_result / 100000.0;
        end else begin
            result5 = 0.0;
        end
        //$display("Numerator for y5: %d", numerator);
        //$display("Denominator for y5: %d", denominator);
        //$display("Result 5: %f", result5 * y5);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x7) * (x_input - x8));
        denominator = ((x6 - x1) * (x6 - x2) * (x6 - x3) * (x6 - x4) * (x6 - x5) * (x6 - x7) * (x6 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result6 = scaled_result / 100000.0;
        end else begin
            result6 = 0.0;
        end
        //$display("Numerator for y6: %d", numerator);
        //$display("Denominator for y6: %d", denominator);
        //$display("Result 6: %f", result6 * y6);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x8));
        denominator = ((x7 - x1) * (x7 - x2) * (x7 - x3) * (x7 - x4) * (x7 - x5) * (x7 - x6) * (x7 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result7 = scaled_result / 100000.0;
        end else begin
            result7 = 0.0;
        end
        //$display("Numerator for y7: %d", numerator);
        //$display("Denominator for y7: %d", denominator);
        //$display("Result 7: %f", result7 * y7);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7));
        denominator = ((x8 - x1) * (x8 - x2) * (x8 - x3) * (x8 - x4) * (x8 - x5) * (x8 - x6) * (x8 - x7));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result8 = scaled_result / 100000.0;
        end else begin
            result8 = 0.0;
        end
        //$display("Numerator for y8: %d", numerator);
        //$display("Denominator for y8: %d", denominator);
        //$display("Result 8: %f", result8 * y8);

        // Sum all terms together
        final_result = result1 * y1 + result2 * y2 + result3 * y3 + result4 * y4 + result5 * y5 + result6 * y6 + result7 * y7 + result8 * y8;

        // Assign the lower bits of the sum to output
        y_output = final_result; // Ensure you take only the lower bits if needed
    end
endmodule

module data_transfer_with_counter (
    input clk,  // Global clock signal
    input [3:0] data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, 
                data_in6, data_in7, data_in8, data_in9, data_in10, data_in11, // 12 data inputs
    input [11:0] data_clocks, // Clock signal associated with each data input
    output reg [3:0] data_out0, data_out1, data_out2, data_out3, data_out4, data_out5,
                     data_out6, data_out7, data_out8, data_out9, data_out10, data_out11, // 12 outputs
    output reg [2:0] lost_count = 3'b000, // 3-bit counter for lost data
    output reg transfer_failed = 1'b0 // Output to indicate if data transfer failed
);

always @(posedge clk) begin
    // Reset lost count and transfer failed at the beginning of each clock cycle
    transfer_failed = 1'b0;

    // Data transfer and counter logic for each data input
    if (data_clocks[0] == 1'b1) data_out0 = data_in0;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[1] == 1'b1) data_out1 = data_in1;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[2] == 1'b1) data_out2 = data_in2;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[3] == 1'b1) data_out3 = data_in3;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[4] == 1'b1) data_out4 = data_in4;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[5] == 1'b1) data_out5 = data_in5;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[6] == 1'b1) data_out6 = data_in6;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[7] == 1'b1) data_out7 = data_in7;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[8] == 1'b1) data_out8 = data_in8;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[9] == 1'b1) data_out9 = data_in9;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[10] == 1'b1) data_out10 = data_in10;
    else lost_count = lost_count + 1'b1;

    if (data_clocks[11] == 1'b1) data_out11 = data_in11;
    else lost_count = lost_count + 1'b1;

    // Trigger transfer_failed if lost_count exceeds 4
    if (lost_count > 3'b100) transfer_failed = 1'b1;
end

endmodule


module lagrange_interpolation2(
    input [3:0] x_input, // Input x (0 to 15)
    input [15:0] y1,
    input [15:0] y2,
    input [15:0] y3,
    input [15:0] y4,
    input [15:0] y5,
    input [15:0] y6,
    input [15:0] y7,
    input [15:0] y8,
    output reg [15:0] y_output // Output y
);
    // Fixed x-coordinates
    parameter [3:0] x1 = 4'd1, x2 = 4'd2, x3 = 4'd3, x4 = 4'd4;
    parameter [3:0] x5 = 4'd9, x6 = 4'd10, x7 = 4'd11, x8 = 4'd12;

    // Declare temporary variables for each term
    reg signed [63:0] numerator, denominator;
    real result1, result2, result3, result4, result5, result6, result7, result8;
    real final_result;
    
    // Scaling factor for fixed-point arithmetic
    integer scaling_factor = 100000;
    reg signed [63:0] scaled_result;
    real intermediate_result;
    always @(*) begin
        // Initialize output and sum
        y_output = 16'd0;
        final_result = 0.0;


        // Calculate numerator and denominator separately for each term
        numerator = ((x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x1 - x2) * (x1 - x3) * (x1 - x4) * (x1 - x5) * (x1 - x6) * (x1 - x7) * (x1 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            //$display("Scaled result is : %d",scaled_result);
            result1 = scaled_result / 100000.0;
        end else begin
            result1 = 0.0;
        end
        //$display("Numerator for y1: %d", numerator);
        //$display("Denominator for y1: %d", denominator);
        //$display("Result 1: %f", result1 * y1);

        numerator = ((x_input - x1) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x2 - x1) * (x2 - x3) * (x2 - x4) * (x2 - x5) * (x2 - x6) * (x2 - x7) * (x2 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result2 = scaled_result / 100000.0;
        end else begin
            result2 = 0.0;
        end
        //$display("Numerator for y2: %d", numerator);
        //$display("Denominator for y2: %d", denominator);
        //$display("Result 2: %f", result2 * y2);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x3 - x1) * (x3 - x2) * (x3 - x4) * (x3 - x5) * (x3 - x6) * (x3 - x7) * (x3 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result3 = scaled_result / 100000.0;
        end else begin
            result3 = 0.0;
        end
        //$display("Numerator for y3: %d", numerator);
        //$display("Denominator for y3: %d", denominator);
        //$display("Result 3: %f", result3 * y3);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x5) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x4 - x1) * (x4 - x2) * (x4 - x3) * (x4 - x5) * (x4 - x6) * (x4 - x7) * (x4 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result4 = scaled_result / 100000.0;
        end else begin
            result4 = 0.0;
        end
        //$display("Numerator for y4: %d", numerator);
        //$display("Denominator for y4: %d", denominator);
        //$display("Result 4: %f", result4 * y4);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x6) * (x_input - x7) * (x_input - x8));
        denominator = ((x5 - x1) * (x5 - x2) * (x5 - x3) * (x5 - x4) * (x5 - x6) * (x5 - x7) * (x5 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result5 = scaled_result / 100000.0;
        end else begin
            result5 = 0.0;
        end
        //$display("Numerator for y5: %d", numerator);
        //$display("Denominator for y5: %d", denominator);
        //$display("Result 5: %f", result5 * y5);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x7) * (x_input - x8));
        denominator = ((x6 - x1) * (x6 - x2) * (x6 - x3) * (x6 - x4) * (x6 - x5) * (x6 - x7) * (x6 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result6 = scaled_result / 100000.0;
        end else begin
            result6 = 0.0;
        end
        //$display("Numerator for y6: %d", numerator);
        //$display("Denominator for y6: %d", denominator);
        //$display("Result 6: %f", result6 * y6);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x8));
        denominator = ((x7 - x1) * (x7 - x2) * (x7 - x3) * (x7 - x4) * (x7 - x5) * (x7 - x6) * (x7 - x8));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result7 = scaled_result / 100000.0;
        end else begin
            result7 = 0.0;
        end
        //$display("Numerator for y7: %d", numerator);
        //$display("Denominator for y7: %d", denominator);
        //$display("Result 7: %f", result7 * y7);

        numerator = ((x_input - x1) * (x_input - x2) * (x_input - x3) * (x_input - x4) * (x_input - x5) * (x_input - x6) * (x_input - x7));
        denominator = ((x8 - x1) * (x8 - x2) * (x8 - x3) * (x8 - x4) * (x8 - x5) * (x8 - x6) * (x8 - x7));
        if (denominator != 0) begin
            scaled_result = numerator * scaling_factor / denominator;
            result8 = scaled_result / 100000.0;
        end else begin
            result8 = 0.0;
        end
        //$display("Numerator for y8: %d", numerator);
        //$display("Denominator for y8: %d", denominator);
        //$display("Result 8: %f", result8 * y8);

        // Sum all terms together
        final_result = result1 * y1 + result2 * y2 + result3 * y3 + result4 * y4 + result5 * y5 + result6 * y6 + result7 * y7 + result8 * y8;

        // Assign the lower bits of the sum to output
        y_output = final_result; 
    end
endmodule

module decrypt_vigenere_cipher (
    input [3:0] key, // 4-bit key
    input [3:0] data_in0,
    input [3:0] data_in1,
    input [3:0] data_in2,
    input [3:0] data_in3,
    input [3:0] data_in4,
    input [3:0] data_in5,
    input [3:0] data_in6,
    input [3:0] data_in7,
    output reg [3:0] data_out0,
    output reg [3:0] data_out1,
    output reg [3:0] data_out2,
    output reg [3:0] data_out3,
    output reg [3:0] data_out4,
    output reg [3:0] data_out5,
    output reg [3:0] data_out6,
    output reg [3:0] data_out7
);

always @(*) begin
    // Decrypt each input by subtracting the key and applying modulo 8
    data_out0 = (data_in0 - key) % 8; 
    data_out1 = (data_in1 - key) % 8;
    data_out2 = (data_in2 - key) % 8;
    data_out3 = (data_in3 - key) % 8;
    data_out4 = (data_in4 - key) % 8;
    data_out5 = (data_in5 - key) % 8;
    data_out6 = (data_in6 - key) % 8;
    data_out7 = (data_in7 - key) % 8;
end

endmodule


module comparator_4bit (
    input [3:0] A,  // First 4-bit number
    input [3:0] B,  // Second 4-bit number
    output equal    // Output 1 if A and B are equal, else 0
);

    // Internal wires for checking equality of each bit
    wire eq0, eq1, eq2, eq3;  // Signals for each bit comparison

    // Compare each bit using XOR gates followed by NOT gates for equality check
    not (eq0, A[0] ^ B[0]); // eq0 = 1 if A[0] == B[0]
    not (eq1, A[1] ^ B[1]); // eq1 = 1 if A[1] == B[1]
    not (eq2, A[2] ^ B[2]); // eq2 = 1 if A[2] == B[2]
    not (eq3, A[3] ^ B[3]); // eq3 = 1 if A[3] == B[3]

    // Use AND gate to combine the equality signals
    wire and1, and2;

    and (and1, eq0, eq1);  // and1 = eq0 AND eq1
    and (and2, eq2, eq3);  // and2 = eq2 AND eq3

    and (equal, and1, and2); // equal = and1 AND and2

endmodule

module comparator_8x4 (
    input [3:0] A0, A1, A2, A3, A4, A5, A6, A7,  // First set of 8 4-bit numbers
    input [3:0] B0, B1, B2, B3, B4, B5, B6, B7,  // Second set of 8 4-bit numbers
    output equal // Output 1 if all corresponding pairs are equal, else 0
);

    // Wires to hold results of individual comparisons
    wire eq0, eq1, eq2, eq3, eq4, eq5, eq6, eq7;

    // Instantiate 8 comparators
    comparator_4bit comp0 (.A(A0), .B(B0), .equal(eq0));
    comparator_4bit comp1 (.A(A1), .B(B1), .equal(eq1));
    comparator_4bit comp2 (.A(A2), .B(B2), .equal(eq2));
    comparator_4bit comp3 (.A(A3), .B(B3), .equal(eq3));
    comparator_4bit comp4 (.A(A4), .B(B4), .equal(eq4));
    comparator_4bit comp5 (.A(A5), .B(B5), .equal(eq5));
    comparator_4bit comp6 (.A(A6), .B(B6), .equal(eq6));
    comparator_4bit comp7 (.A(A7), .B(B7), .equal(eq7));

    // Combine the outputs of the 8 comparators using AND gates
    wire and1, and2;

    and (and1, eq0, eq1);  // and1 = eq0 AND eq1
    and (and2, eq2, eq3);  // and2 = eq2 AND eq3

    wire and3, and4;

    and (and3, eq4, eq5);  // and3 = eq4 AND eq5
    and (and4, eq6, eq7);  // and4 = eq6 AND eq7

    wire final_and1, final_and2;

    and (final_and1, and1, and2); // final_and1 = and1 AND and2
    and (final_and2, and3, and4); // final_and2 = and3 AND and4

    // Final AND gate to determine overall equality
    and (equal, final_and1, final_and2); // equal = final_and1 AND final_and2

endmodule


