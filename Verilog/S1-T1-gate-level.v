// S1-T1-Reed-Solomon-Codes
// Data Recovery and Error Correction in Space Communication

// Gate level model

// Member-1: Akshat Bharara, Roll No: 231CS110
// Member-2: Dev Prajapati, Roll No: 231CS120
// Member-3: Vatsal Jay Gandhi, Roll No: 231CS164

// Full Adder for 1-bit addition
module full_adder(
    input a, b, carry_in,
    output sum, carry_out
);
    wire ab_xor, ab_and, carry_in_xor;
    
    // Sum = a XOR b XOR carry_in
    xor(ab_xor, a, b);
    xor(sum, ab_xor, carry_in);
    
    // Carry_out = (a AND b) OR (carry_in AND (a XOR b))
    and(ab_and, a, b);
    and(carry_in_xor, carry_in, ab_xor);
    or(carry_out, ab_and, carry_in_xor);
endmodule


// 4-bit adder using full adders
module four_bit_adder(
    input [3:0] a, b, 
    output [3:0] sum,
    output carry_out
);
    wire carry0, carry1, carry2;  // Intermediate carry bits
    
    // Full adders for each bit
    full_adder FA0(a[0], b[0], 1'b0, sum[0], carry0);  // First bit with no carry_in
    full_adder FA1(a[1], b[1], carry0, sum[1], carry1);
    full_adder FA2(a[2], b[2], carry1, sum[2], carry2);
    full_adder FA3(a[3], b[3], carry2, sum[3], carry_out);  // Final carry_out
endmodule


// Modulo 8 operation (Mask the result to 3 bits)
module mod8(
    input [3:0] data_in,
    output [3:0] data_out
);
    and(data_out[0], data_in[0], 1);
    and(data_out[1], data_in[1], 1);
    and(data_out[2], data_in[2], 1);
    and(data_out[3], data_in[3], 0);  // Mask the 4th bit to 0
endmodule


module encypt_vigenere_cipher (
    input [3:0] key,      // 4-bit key
    input [3:0] data_in0, data_in1, data_in2, data_in3, 
    input [3:0] data_in4, data_in5, data_in6, data_in7,
    output [3:0] data_out0, data_out1, data_out2, data_out3, 
    output [3:0] data_out4, data_out5, data_out6, data_out7
);

    // Instantiate 4-bit adders and modulo logic
    wire [3:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7;
    wire carry_out0, carry_out1, carry_out2, carry_out3;
    wire carry_out4, carry_out5, carry_out6, carry_out7;
    
    // Add key to data_in values
    four_bit_adder FA0(data_in0, key, sum0, carry_out0);
    four_bit_adder FA1(data_in1, key, sum1, carry_out1);
    four_bit_adder FA2(data_in2, key, sum2, carry_out2);
    four_bit_adder FA3(data_in3, key, sum3, carry_out3);
    four_bit_adder FA4(data_in4, key, sum4, carry_out4);
    four_bit_adder FA5(data_in5, key, sum5, carry_out5);
    four_bit_adder FA6(data_in6, key, sum6, carry_out6);
    four_bit_adder FA7(data_in7, key, sum7, carry_out7);

    // Apply modulo 8 to each sum
    mod8 MOD0(sum0, data_out0);
    mod8 MOD1(sum1, data_out1);
    mod8 MOD2(sum2, data_out2);
    mod8 MOD3(sum3, data_out3);
    mod8 MOD4(sum4, data_out4);
    mod8 MOD5(sum5, data_out5);
    mod8 MOD6(sum6, data_out6);
    mod8 MOD7(sum7, data_out7);

endmodule

module subtractor(
    input [3:0] a,  // Minuend
    input [3:0] b,  // Subtrahend
    output [3:0] result, // Result of a - b
    output borrow // Borrow output
);
    wire [3:0] b_inv;
    wire [3:0] temp_result;
    wire borrow1, borrow2, borrow3;

    // Invert b for the subtraction
    assign b_inv = ~b;

    // Full subtractor logic for each bit
    assign {borrow1, temp_result[0]} = {1'b0, a[0]} - {1'b0, b_inv[0]};
    assign {borrow2, temp_result[1]} = {1'b0, a[1]} - {1'b0, b_inv[1]} - borrow1;
    assign {borrow3, temp_result[2]} = {1'b0, a[2]} - {1'b0, b_inv[2]} - borrow2;
    assign {borrow, temp_result[3]} = {1'b0, a[3]} - {1'b0, b_inv[3]} - borrow3;

    // Assign result
    assign result = temp_result;

endmodule


module data_transfer_with_counter (
    input clk,  // Global clock signal
    input [3:0] data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, 
                data_in6, data_in7, data_in8, data_in9, data_in10, data_in11, // 12 data inputs
    input [11:0] data_clocks, // Clock signal associated with each data input
    output [3:0] data_out0, data_out1, data_out2, data_out3, data_out4, data_out5,
                 data_out6, data_out7, data_out8, data_out9, data_out10, data_out11, // 12 outputs
    output [2:0] lost_count, // 3-bit counter for lost data
    output transfer_failed // Output to indicate if data transfer failed
);

    wire [2:0] next_lost_count;      // Wire for next lost count
    wire lost_count_exceeds_4;       // Wire to check if lost count exceeds 4

    // 12 MUXs for data transfer based on data clocks
    mux2_1 data_mux0 (data_in0, data_out0, data_clocks[0], data_out0);
    mux2_1 data_mux1 (data_in1, data_out1, data_clocks[1], data_out1);
    mux2_1 data_mux2 (data_in2, data_out2, data_clocks[2], data_out2);
    mux2_1 data_mux3 (data_in3, data_out3, data_clocks[3], data_out3);
    mux2_1 data_mux4 (data_in4, data_out4, data_clocks[4], data_out4);
    mux2_1 data_mux5 (data_in5, data_out5, data_clocks[5], data_out5);
    mux2_1 data_mux6 (data_in6, data_out6, data_clocks[6], data_out6);
    mux2_1 data_mux7 (data_in7, data_out7, data_clocks[7], data_out7);
    mux2_1 data_mux8 (data_in8, data_out8, data_clocks[8], data_out8);
    mux2_1 data_mux9 (data_in9, data_out9, data_clocks[9], data_out9);
    mux2_1 data_mux10 (data_in10, data_out10, data_clocks[10], data_out10);
    mux2_1 data_mux11 (data_in11, data_out11, data_clocks[11], data_out11);

    // 3-bit counter for lost count using D flip-flops
    d_flipflop dff0 (next_lost_count[0], clk, lost_count[0], lost_count[0]);
    d_flipflop dff1 (next_lost_count[1], clk, lost_count[1], lost_count[1]);
    d_flipflop dff2 (next_lost_count[2], clk, lost_count[2], lost_count[2]);

    // Logic to compute the next value of lost count based on missed data transfers
    // Increment lost_count when data clock is low for each data input
    add3_gatelevel lost_counter (
        .A(lost_count),
        .clocks(data_clocks),  // Logic that evaluates missed data transfers
        .result(next_lost_count)
    );

    // Comparator to check if lost count > 4
    comparator_gt4 compare_gt4 (.A(lost_count), .result(lost_count_exceeds_4));

    // Transfer failed signal logic
    assign transfer_failed = lost_count_exceeds_4;

endmodule

// 2-to-1 MUX module
module mux2_1 (
    input [3:0] data_in,    // Data input
    input [3:0] data_out,   // Current data output
    input select,           // Data clock as select signal
    output [3:0] result     // Output of MUX
);
    wire not_select;             // Inverted select signal
    wire [3:0] selected_data_in; // Selected data from data_in
    wire [3:0] selected_data_out; // Selected data from data_out

    // Invert the select signal
    not(not_select, select);

    // Logic for each bit of the multiplexer
    // For bit 0
    and(selected_data_in[0], select, data_in[0]);          // If select is 1, pass data_in[0]
    and(selected_data_out[0], not_select, data_out[0]);    // If select is 0, pass data_out[0]
    or(result[0], selected_data_in[0], selected_data_out[0]); // Output the selected value for bit 0

    // For bit 1
    and(selected_data_in[1], select, data_in[1]);          // If select is 1, pass data_in[1]
    and(selected_data_out[1], not_select, data_out[1]);    // If select is 0, pass data_out[1]
    or(result[1], selected_data_in[1], selected_data_out[1]); // Output the selected value for bit 1

    // For bit 2
    and(selected_data_in[2], select, data_in[2]);          // If select is 1, pass data_in[2]
    and(selected_data_out[2], not_select, data_out[2]);    // If select is 0, pass data_out[2]
    or(result[2], selected_data_in[2], selected_data_out[2]); // Output the selected value for bit 2

    // For bit 3
    and(selected_data_in[3], select, data_in[3]);          // If select is 1, pass data_in[3]
    and(selected_data_out[3], not_select, data_out[3]);    // If select is 0, pass data_out[3]
    or(result[3], selected_data_in[3], selected_data_out[3]); // Output the selected value for bit 3

endmodule

// 3-bit binary adder (for incrementing lost count)
module add3_gatelevel (
    input [2:0] A,       // Current lost count
    input [11:0] clocks, // Data clocks to determine if increment needed
    output [2:0] result  // Resulting lost count after increment
);
    wire increment;           // Signal to determine if we need to increment
    wire [2:0] B;            // Second operand for addition
    wire [2:0] carry;        // Carry bits for the full adders

    // Generate B as a 3-bit binary number representing 1
    assign B = 3'b001;       // We want to add 1

    // OR logic to check if any data_clocks are low
    nor(increment, clocks[0], clocks[1], clocks[2], clocks[3], clocks[4],
                   clocks[5], clocks[6], clocks[7], clocks[8], clocks[9],
                   clocks[10], clocks[11]);

    // Full adder for the least significant bit
    full_adder2 fa0 (
        .A(A[0]), 
        .B(B[0]), 
        .Cin(increment),   // Use increment as the carry-in
        .Sum(result[0]), 
        .Cout(carry[0])
    );

    // Full adder for the second bit
    full_adder2 fa1 (
        .A(A[1]), 
        .B(B[1]), 
        .Cin(carry[0]),    // Connect the carry-out of the previous adder
        .Sum(result[1]), 
        .Cout(carry[1])
    );

    // Full adder for the most significant bit
    full_adder2 fa2 (
        .A(A[2]), 
        .B(B[2]), 
        .Cin(carry[1]),    // Connect the carry-out of the previous adder
        .Sum(result[2]), 
        .Cout()             // Final carry-out is not used
    );

endmodule

// Full adder module definition
module full_adder2 (
    input A,        // First input
    input B,        // Second input
    input Cin,      // Carry input
    output Sum,     // Sum output
    output Cout     // Carry output
);
    wire AxorB;     // Intermediate signal for XOR

    // Sum = A XOR B XOR Cin
    xor (AxorB, A, B);
    xor (Sum, AxorB, Cin);

    // Cout = (A AND B) OR (Cin AND (A XOR B))
    wire AandB, CinandAxorB;
    and (AandB, A, B);
    and (CinandAxorB, Cin, AxorB);
    or (Cout, AandB, CinandAxorB);
endmodule

// Comparator module to check if lost count > 4 (binary 100)
module comparator_gt4 (
    input [2:0] A,
    output result
);
    wire A2_not, A1, A0;

    not(A2_not, A[2]); // A[2] is the most significant bit
    assign A1 = A[1];
    assign A0 = A[0];

    // Logic for A > 4: If A[2] = 1 and A[1] = 0 (binary 100)
    and(result, A[2], A2_not);
endmodule

// D Flip-Flop module
module d_flipflop (
    input D, 
    input clk, 
    output Q,
    output Qn
);
    wire D_nand,Q_int, Qn_int;
    nand(D_nand,D,clk);
    nand(Q,D_nand,Qn_int);
    nand(Qn_int,Q,D);

    assign Qn = Qn_int;

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

    // Wires for subtraction results
    wire [3:0] x_input_x1_diff, x_input_x2_diff, x_input_x3_diff, x_input_x4_diff, x_input_x5_diff;
    wire [3:0] x_input_x6_diff, x_input_x7_diff, x_input_x8_diff;
    wire [3:0] x1_x2_diff, x1_x3_diff, x1_x4_diff, x1_x5_diff, x1_x6_diff, x1_x7_diff, x1_x8_diff;
    wire [3:0] x2_x1_diff, x2_x3_diff, x2_x4_diff, x2_x5_diff, x2_x6_diff, x2_x7_diff, x2_x8_diff;
    wire [3:0] x3_x1_diff, x3_x2_diff, x3_x4_diff, x3_x5_diff, x3_x6_diff, x3_x7_diff, x3_x8_diff;
    wire [3:0] x4_x1_diff, x4_x2_diff, x4_x3_diff, x4_x5_diff, x4_x6_diff, x4_x7_diff, x4_x8_diff;
    wire [3:0] x5_x1_diff, x5_x2_diff, x5_x3_diff, x5_x4_diff, x5_x6_diff, x5_x7_diff, x5_x8_diff;
    wire [3:0] x6_x1_diff, x6_x2_diff, x6_x3_diff, x6_x4_diff, x6_x5_diff, x6_x7_diff, x6_x8_diff;
    wire [3:0] x7_x1_diff, x7_x2_diff, x7_x3_diff, x7_x4_diff, x7_x5_diff, x7_x6_diff, x7_x8_diff;
    wire [3:0] x8_x1_diff, x8_x2_diff, x8_x3_diff, x8_x4_diff, x8_x5_diff, x8_x6_diff, x8_x7_diff;

    // Instantiate subtractor modules for x_input
    subtractor sub_input_x1(.a(x_input), .b(x1), .result(x_input_x1_diff), .borrow());
    subtractor sub_input_x2(.a(x_input), .b(x2), .result(x_input_x2_diff), .borrow());
    subtractor sub_input_x3(.a(x_input), .b(x3), .result(x_input_x3_diff), .borrow());
    subtractor sub_input_x4(.a(x_input), .b(x4), .result(x_input_x4_diff), .borrow());
    subtractor sub_input_x5(.a(x_input), .b(x5), .result(x_input_x5_diff), .borrow());
    subtractor sub_input_x6(.a(x_input), .b(x6), .result(x_input_x6_diff), .borrow());
    subtractor sub_input_x7(.a(x_input), .b(x7), .result(x_input_x7_diff), .borrow());
    subtractor sub_input_x8(.a(x_input), .b(x8), .result(x_input_x8_diff), .borrow());

    // Instantiate subtractor modules for fixed x coordinates
    subtractor sub_x1_x2(.a(x1), .b(x2), .result(x1_x2_diff), .borrow());
    subtractor sub_x1_x3(.a(x1), .b(x3), .result(x1_x3_diff), .borrow());
    subtractor sub_x1_x4(.a(x1), .b(x4), .result(x1_x4_diff), .borrow());
    subtractor sub_x1_x5(.a(x1), .b(x5), .result(x1_x5_diff), .borrow());
    subtractor sub_x1_x6(.a(x1), .b(x6), .result(x1_x6_diff), .borrow());
    subtractor sub_x1_x7(.a(x1), .b(x7), .result(x1_x7_diff), .borrow());
    subtractor sub_x1_x8(.a(x1), .b(x8), .result(x1_x8_diff), .borrow());

    subtractor sub_x2_x1(.a(x2), .b(x1), .result(x2_x1_diff), .borrow());
    subtractor sub_x2_x3(.a(x2), .b(x3), .result(x2_x3_diff), .borrow());
    subtractor sub_x2_x4(.a(x2), .b(x4), .result(x2_x4_diff), .borrow());
    subtractor sub_x2_x5(.a(x2), .b(x5), .result(x2_x5_diff), .borrow());
    subtractor sub_x2_x6(.a(x2), .b(x6), .result(x2_x6_diff), .borrow());
    subtractor sub_x2_x7(.a(x2), .b(x7), .result(x2_x7_diff), .borrow());
    subtractor sub_x2_x8(.a(x2), .b(x8), .result(x2_x8_diff), .borrow());

    subtractor sub_x3_x1(.a(x3), .b(x1), .result(x3_x1_diff), .borrow());
    subtractor sub_x3_x2(.a(x3), .b(x2), .result(x3_x2_diff), .borrow());
    subtractor sub_x3_x4(.a(x3), .b(x4), .result(x3_x4_diff), .borrow());
    subtractor sub_x3_x5(.a(x3), .b(x5), .result(x3_x5_diff), .borrow());
    subtractor sub_x3_x6(.a(x3), .b(x6), .result(x3_x6_diff), .borrow());
    subtractor sub_x3_x7(.a(x3), .b(x7), .result(x3_x7_diff), .borrow());
    subtractor sub_x3_x8(.a(x3), .b(x8), .result(x3_x8_diff), .borrow());

    subtractor sub_x4_x1(.a(x4), .b(x1), .result(x4_x1_diff), .borrow());
    subtractor sub_x4_x2(.a(x4), .b(x2), .result(x4_x2_diff), .borrow());
    subtractor sub_x4_x3(.a(x4), .b(x3), .result(x4_x3_diff), .borrow());
    subtractor sub_x4_x5(.a(x4), .b(x5), .result(x4_x5_diff), .borrow());
    subtractor sub_x4_x6(.a(x4), .b(x6), .result(x4_x6_diff), .borrow());
    subtractor sub_x4_x7(.a(x4), .b(x7), .result(x4_x7_diff), .borrow());
    subtractor sub_x4_x8(.a(x4), .b(x8), .result(x4_x8_diff), .borrow());

    subtractor sub_x5_x1(.a(x5), .b(x1), .result(x5_x1_diff), .borrow());
    subtractor sub_x5_x2(.a(x5), .b(x2), .result(x5_x2_diff), .borrow());
    subtractor sub_x5_x3(.a(x5), .b(x3), .result(x5_x3_diff), .borrow());
    subtractor sub_x5_x4(.a(x5), .b(x4), .result(x5_x4_diff), .borrow());
    subtractor sub_x5_x6(.a(x5), .b(x6), .result(x5_x6_diff), .borrow());
    subtractor sub_x5_x7(.a(x5), .b(x7), .result(x5_x7_diff), .borrow());
    subtractor sub_x5_x8(.a(x5), .b(x8), .result(x5_x8_diff), .borrow());

    subtractor sub_x6_x1(.a(x6), .b(x1), .result(x6_x1_diff), .borrow());
    subtractor sub_x6_x2(.a(x6), .b(x2), .result(x6_x2_diff), .borrow());
    subtractor sub_x6_x3(.a(x6), .b(x3), .result(x6_x3_diff), .borrow());
    subtractor sub_x6_x4(.a(x6), .b(x4), .result(x6_x4_diff), .borrow());
    subtractor sub_x6_x5(.a(x6), .b(x5), .result(x6_x5_diff), .borrow());
    subtractor sub_x6_x7(.a(x6), .b(x7), .result(x6_x7_diff), .borrow());
    subtractor sub_x6_x8(.a(x6), .b(x8), .result(x6_x8_diff), .borrow());

    subtractor sub_x7_x1(.a(x7), .b(x1), .result(x7_x1_diff), .borrow());
    subtractor sub_x7_x2(.a(x7), .b(x2), .result(x7_x2_diff), .borrow());
    subtractor sub_x7_x3(.a(x7), .b(x3), .result(x7_x3_diff), .borrow());
    subtractor sub_x7_x4(.a(x7), .b(x4), .result(x7_x4_diff), .borrow());
    subtractor sub_x7_x5(.a(x7), .b(x5), .result(x7_x5_diff), .borrow());
    subtractor sub_x7_x6(.a(x7), .b(x6), .result(x7_x6_diff), .borrow());
    subtractor sub_x7_x8(.a(x7), .b(x8), .result(x7_x8_diff), .borrow());

    subtractor sub_x8_x1(.a(x8), .b(x1), .result(x8_x1_diff), .borrow());
    subtractor sub_x8_x2(.a(x8), .b(x2), .result(x8_x2_diff), .borrow());
    subtractor sub_x8_x3(.a(x8), .b(x3), .result(x8_x3_diff), .borrow());
    subtractor sub_x8_x4(.a(x8), .b(x4), .result(x8_x4_diff), .borrow());
    subtractor sub_x8_x5(.a(x8), .b(x5), .result(x8_x5_diff), .borrow());
    subtractor sub_x8_x6(.a(x8), .b(x6), .result(x8_x6_diff), .borrow());
    subtractor sub_x8_x7(.a(x8), .b(x7), .result(x8_x7_diff), .borrow());

    always @(*) begin
        // Reset results
        numerator = 0;
        denominator = 1;

        // Calculate Lagrange interpolation for each term
        numerator += (y1 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x1_x2_diff * x1_x3_diff * x1_x4_diff);

        numerator += (y2 * x_input_x1_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x2_x1_diff * x2_x3_diff * x2_x4_diff);

        numerator += (y3 * x_input_x1_diff * x_input_x2_diff * x_input_x4_diff);
        denominator *= (x3_x1_diff * x3_x2_diff * x3_x4_diff);

        numerator += (y4 * x_input_x1_diff * x_input_x2_diff * x_input_x3_diff);
        denominator *= (x4_x1_diff * x4_x2_diff * x4_x3_diff);

        numerator += (y5 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x5_x1_diff * x5_x2_diff * x5_x3_diff * x5_x4_diff);

        numerator += (y6 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x6_x1_diff * x6_x2_diff * x6_x3_diff * x6_x4_diff);

        numerator += (y7 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x7_x1_diff * x7_x2_diff * x7_x3_diff * x7_x4_diff);

        numerator += (y8 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x8_x1_diff * x8_x2_diff * x8_x3_diff * x8_x4_diff);

        // Scale and assign result to output
        scaled_result = (numerator * scaling_factor) / denominator;
        y_output = scaled_result[15:0]; // Assign to the output
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

    // Wires for subtraction results
    wire [3:0] x_input_x1_diff, x_input_x2_diff, x_input_x3_diff, x_input_x4_diff, x_input_x5_diff;
    wire [3:0] x_input_x6_diff, x_input_x7_diff, x_input_x8_diff;
    wire [3:0] x1_x2_diff, x1_x3_diff, x1_x4_diff, x1_x5_diff, x1_x6_diff, x1_x7_diff, x1_x8_diff;
    wire [3:0] x2_x1_diff, x2_x3_diff, x2_x4_diff, x2_x5_diff, x2_x6_diff, x2_x7_diff, x2_x8_diff;
    wire [3:0] x3_x1_diff, x3_x2_diff, x3_x4_diff, x3_x5_diff, x3_x6_diff, x3_x7_diff, x3_x8_diff;
    wire [3:0] x4_x1_diff, x4_x2_diff, x4_x3_diff, x4_x5_diff, x4_x6_diff, x4_x7_diff, x4_x8_diff;
    wire [3:0] x5_x1_diff, x5_x2_diff, x5_x3_diff, x5_x4_diff, x5_x6_diff, x5_x7_diff, x5_x8_diff;
    wire [3:0] x6_x1_diff, x6_x2_diff, x6_x3_diff, x6_x4_diff, x6_x5_diff, x6_x7_diff, x6_x8_diff;
    wire [3:0] x7_x1_diff, x7_x2_diff, x7_x3_diff, x7_x4_diff, x7_x5_diff, x7_x6_diff, x7_x8_diff;
    wire [3:0] x8_x1_diff, x8_x2_diff, x8_x3_diff, x8_x4_diff, x8_x5_diff, x8_x6_diff, x8_x7_diff;

    // Instantiate subtractor modules for x_input
    subtractor sub_input_x1(.a(x_input), .b(x1), .result(x_input_x1_diff), .borrow());
    subtractor sub_input_x2(.a(x_input), .b(x2), .result(x_input_x2_diff), .borrow());
    subtractor sub_input_x3(.a(x_input), .b(x3), .result(x_input_x3_diff), .borrow());
    subtractor sub_input_x4(.a(x_input), .b(x4), .result(x_input_x4_diff), .borrow());
    subtractor sub_input_x5(.a(x_input), .b(x5), .result(x_input_x5_diff), .borrow());
    subtractor sub_input_x6(.a(x_input), .b(x6), .result(x_input_x6_diff), .borrow());
    subtractor sub_input_x7(.a(x_input), .b(x7), .result(x_input_x7_diff), .borrow());
    subtractor sub_input_x8(.a(x_input), .b(x8), .result(x_input_x8_diff), .borrow());

    // Instantiate subtractor modules for fixed x coordinates
    subtractor sub_x1_x2(.a(x1), .b(x2), .result(x1_x2_diff), .borrow());
    subtractor sub_x1_x3(.a(x1), .b(x3), .result(x1_x3_diff), .borrow());
    subtractor sub_x1_x4(.a(x1), .b(x4), .result(x1_x4_diff), .borrow());
    subtractor sub_x1_x5(.a(x1), .b(x5), .result(x1_x5_diff), .borrow());
    subtractor sub_x1_x6(.a(x1), .b(x6), .result(x1_x6_diff), .borrow());
    subtractor sub_x1_x7(.a(x1), .b(x7), .result(x1_x7_diff), .borrow());
    subtractor sub_x1_x8(.a(x1), .b(x8), .result(x1_x8_diff), .borrow());

    subtractor sub_x2_x1(.a(x2), .b(x1), .result(x2_x1_diff), .borrow());
    subtractor sub_x2_x3(.a(x2), .b(x3), .result(x2_x3_diff), .borrow());
    subtractor sub_x2_x4(.a(x2), .b(x4), .result(x2_x4_diff), .borrow());
    subtractor sub_x2_x5(.a(x2), .b(x5), .result(x2_x5_diff), .borrow());
    subtractor sub_x2_x6(.a(x2), .b(x6), .result(x2_x6_diff), .borrow());
    subtractor sub_x2_x7(.a(x2), .b(x7), .result(x2_x7_diff), .borrow());
    subtractor sub_x2_x8(.a(x2), .b(x8), .result(x2_x8_diff), .borrow());

    subtractor sub_x3_x1(.a(x3), .b(x1), .result(x3_x1_diff), .borrow());
    subtractor sub_x3_x2(.a(x3), .b(x2), .result(x3_x2_diff), .borrow());
    subtractor sub_x3_x4(.a(x3), .b(x4), .result(x3_x4_diff), .borrow());
    subtractor sub_x3_x5(.a(x3), .b(x5), .result(x3_x5_diff), .borrow());
    subtractor sub_x3_x6(.a(x3), .b(x6), .result(x3_x6_diff), .borrow());
    subtractor sub_x3_x7(.a(x3), .b(x7), .result(x3_x7_diff), .borrow());
    subtractor sub_x3_x8(.a(x3), .b(x8), .result(x3_x8_diff), .borrow());

    subtractor sub_x4_x1(.a(x4), .b(x1), .result(x4_x1_diff), .borrow());
    subtractor sub_x4_x2(.a(x4), .b(x2), .result(x4_x2_diff), .borrow());
    subtractor sub_x4_x3(.a(x4), .b(x3), .result(x4_x3_diff), .borrow());
    subtractor sub_x4_x5(.a(x4), .b(x5), .result(x4_x5_diff), .borrow());
    subtractor sub_x4_x6(.a(x4), .b(x6), .result(x4_x6_diff), .borrow());
    subtractor sub_x4_x7(.a(x4), .b(x7), .result(x4_x7_diff), .borrow());
    subtractor sub_x4_x8(.a(x4), .b(x8), .result(x4_x8_diff), .borrow());

    subtractor sub_x5_x1(.a(x5), .b(x1), .result(x5_x1_diff), .borrow());
    subtractor sub_x5_x2(.a(x5), .b(x2), .result(x5_x2_diff), .borrow());
    subtractor sub_x5_x3(.a(x5), .b(x3), .result(x5_x3_diff), .borrow());
    subtractor sub_x5_x4(.a(x5), .b(x4), .result(x5_x4_diff), .borrow());
    subtractor sub_x5_x6(.a(x5), .b(x6), .result(x5_x6_diff), .borrow());
    subtractor sub_x5_x7(.a(x5), .b(x7), .result(x5_x7_diff), .borrow());
    subtractor sub_x5_x8(.a(x5), .b(x8), .result(x5_x8_diff), .borrow());

    subtractor sub_x6_x1(.a(x6), .b(x1), .result(x6_x1_diff), .borrow());
    subtractor sub_x6_x2(.a(x6), .b(x2), .result(x6_x2_diff), .borrow());
    subtractor sub_x6_x3(.a(x6), .b(x3), .result(x6_x3_diff), .borrow());
    subtractor sub_x6_x4(.a(x6), .b(x4), .result(x6_x4_diff), .borrow());
    subtractor sub_x6_x5(.a(x6), .b(x5), .result(x6_x5_diff), .borrow());
    subtractor sub_x6_x7(.a(x6), .b(x7), .result(x6_x7_diff), .borrow());
    subtractor sub_x6_x8(.a(x6), .b(x8), .result(x6_x8_diff), .borrow());

    subtractor sub_x7_x1(.a(x7), .b(x1), .result(x7_x1_diff), .borrow());
    subtractor sub_x7_x2(.a(x7), .b(x2), .result(x7_x2_diff), .borrow());
    subtractor sub_x7_x3(.a(x7), .b(x3), .result(x7_x3_diff), .borrow());
    subtractor sub_x7_x4(.a(x7), .b(x4), .result(x7_x4_diff), .borrow());
    subtractor sub_x7_x5(.a(x7), .b(x5), .result(x7_x5_diff), .borrow());
    subtractor sub_x7_x6(.a(x7), .b(x6), .result(x7_x6_diff), .borrow());
    subtractor sub_x7_x8(.a(x7), .b(x8), .result(x7_x8_diff), .borrow());

    subtractor sub_x8_x1(.a(x8), .b(x1), .result(x8_x1_diff), .borrow());
    subtractor sub_x8_x2(.a(x8), .b(x2), .result(x8_x2_diff), .borrow());
    subtractor sub_x8_x3(.a(x8), .b(x3), .result(x8_x3_diff), .borrow());
    subtractor sub_x8_x4(.a(x8), .b(x4), .result(x8_x4_diff), .borrow());
    subtractor sub_x8_x5(.a(x8), .b(x5), .result(x8_x5_diff), .borrow());
    subtractor sub_x8_x6(.a(x8), .b(x6), .result(x8_x6_diff), .borrow());
    subtractor sub_x8_x7(.a(x8), .b(x7), .result(x8_x7_diff), .borrow());

    always @(*) begin
        // Reset results
        numerator = 0;
        denominator = 1;

        // Calculate Lagrange interpolation for each term
        numerator += (y1 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x1_x2_diff * x1_x3_diff * x1_x4_diff);

        numerator += (y2 * x_input_x1_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x2_x1_diff * x2_x3_diff * x2_x4_diff);

        numerator += (y3 * x_input_x1_diff * x_input_x2_diff * x_input_x4_diff);
        denominator *= (x3_x1_diff * x3_x2_diff * x3_x4_diff);

        numerator += (y4 * x_input_x1_diff * x_input_x2_diff * x_input_x3_diff);
        denominator *= (x4_x1_diff * x4_x2_diff * x4_x3_diff);

        numerator += (y5 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x5_x1_diff * x5_x2_diff * x5_x3_diff * x5_x4_diff);

        numerator += (y6 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x6_x1_diff * x6_x2_diff * x6_x3_diff * x6_x4_diff);

        numerator += (y7 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x7_x1_diff * x7_x2_diff * x7_x3_diff * x7_x4_diff);

        numerator += (y8 * x_input_x2_diff * x_input_x3_diff * x_input_x4_diff);
        denominator *= (x8_x1_diff * x8_x2_diff * x8_x3_diff * x8_x4_diff);

        // Scale and assign result to output
        scaled_result = (numerator * scaling_factor) / denominator;
        y_output = scaled_result[15:0]; // Assign to the output
    end
endmodule


// 1-bit Full Subtractor
module full_subtractor(
    input a, b, borrow_in,
    output diff, borrow_out
);
    wire x1, x2, x3, n1;
    
    xor(x1, a, b);
    xor(diff, x1, borrow_in);
    
    not(n1, a);
    and(x2, n1, b);
    and(x3, n1, borrow_in);
    or(borrow_out, x2, x3);
endmodule

// 4-bit Subtractor
module four_bit_subtractor(
    input [3:0] a, b,
    output [3:0] diff,
    output borrow_out
);
    wire [2:0] borrow;
    
    full_subtractor fs0(a[0], b[0], 1'b0, diff[0], borrow[0]);
    full_subtractor fs1(a[1], b[1], borrow[0], diff[1], borrow[1]);
    full_subtractor fs2(a[2], b[2], borrow[1], diff[2], borrow[2]);
    full_subtractor fs3(a[3], b[3], borrow[2], diff[3], borrow_out);
endmodule

// Main Vigenere Cipher Decryption module
module decrypt_vigenere_cipher (
    input [3:0] key,
    input [3:0] data_in0, data_in1, data_in2, data_in3,
    input [3:0] data_in4, data_in5, data_in6, data_in7,
    output [3:0] data_out0, data_out1, data_out2, data_out3,
    output [3:0] data_out4, data_out5, data_out6, data_out7
);
    wire [3:0] sub_out0, sub_out1, sub_out2, sub_out3;
    wire [3:0] sub_out4, sub_out5, sub_out6, sub_out7;
    wire borrow_out0, borrow_out1, borrow_out2, borrow_out3;
    wire borrow_out4, borrow_out5, borrow_out6, borrow_out7;

    // Subtraction operations
    four_bit_subtractor sub0(data_in0, key, sub_out0, borrow_out0);
    four_bit_subtractor sub1(data_in1, key, sub_out1, borrow_out1);
    four_bit_subtractor sub2(data_in2, key, sub_out2, borrow_out2);
    four_bit_subtractor sub3(data_in3, key, sub_out3, borrow_out3);
    four_bit_subtractor sub4(data_in4, key, sub_out4, borrow_out4);
    four_bit_subtractor sub5(data_in5, key, sub_out5, borrow_out5);
    four_bit_subtractor sub6(data_in6, key, sub_out6, borrow_out6);
    four_bit_subtractor sub7(data_in7, key, sub_out7, borrow_out7);

    // Modulo operations
    mod8 mod0(sub_out0, data_out0);
    mod8 mod1(sub_out1, data_out1);
    mod8 mod2(sub_out2, data_out2);
    mod8 mod3(sub_out3, data_out3);
    mod8 mod4(sub_out4, data_out4);
    mod8 mod5(sub_out5, data_out5);
    mod8 mod6(sub_out6, data_out6);
    mod8 mod7(sub_out7, data_out7);
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
