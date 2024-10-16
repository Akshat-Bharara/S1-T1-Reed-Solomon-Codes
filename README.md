# Data Recovery and Error Correction in Space Communication

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Member-1: Akshat Bharara, Roll No: 231CS110, email: akshatbharara.231cs110@nitk.edu.in

  > Member-2: Dev Prajapati, Roll No: 231CS120, email: devprajapati.231cs120@nitk.edu.in

  > Member-3: Vatsal Jay Gandhi, Roll No: 231CS164, email: vatsaljaygandhi.231cs164@nitk.edu.in

</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
  <h4>Motivation</h4>
  Space communications are vital in the transmission of data between Earth and spacecraft, covering satellites and space stations. Such systems operate in a highly unpredictable environment where atmospheric interference, cosmic radiation, and huge distances may cause data attenuation. For example, NASA’s Voyager 2 experienced temporary dataloss due to signal degradation in deep space. These examples demonstrate the vulnerability of space communication and call for error free method to securely transmit data and recover lost data significantly.

<h4>Problem Statement</h4>
Our project aims to develop a framework that ensures error recovery and data security in the real-time space communication. Encryption ensures that classified information such as military and governmental data remains confidential. Error recovery mechanisms enable accurate communication in critical applications related to space exploration, disaster management, etc. Our project implements a data recovery system based on Reed-Solomon error correction codes in order to regenerate and recover lost data.

<h4>Features</h4>
<ul>
<li>Encryption for secure data transmission.</li> 
<li>Lagrange interpolation for generating extra bits of information.</li>
<li>Recovery of lost data bits using Reed-Solomon Codes.</li>
<li>Clock-Based Data Integrity Checker to periodically assess data integrity and trigger error correction.</li>
<li>Comparator Logic to verify and decrypt if the recovered encrypted data matches the original stored data.</li>
</ul>

<h4>References</h4>
- https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.html<br>
- https://ieeexplore.ieee.org/document/5194437<br>
  
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary>
  <img src = "https://github.com/user-attachments/assets/816f6b58-48ac-41a1-9db9-a3d11cd5a859" alt="S1-T1-Functional-Block-Diagram">

  
  
</details>

<!-- Third Section -->
## Working

   <details>

  
  <summary>Description</summary>

</details>



<details>
  <summary>Design</summary>
  
</details>



<details>
  <summary>Functional Table</summary>
  <img src = "https://github.com/user-attachments/assets/10cd7ffb-7894-49cb-ba86-64139ad98791"/>

</details>


<details>
  <summary>Flowchart</summary>
  <img src = "https://github.com/user-attachments/assets/45aac615-9306-419e-9eb0-97e366d797f5"/>
</details>

</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  > Update a neat logisim circuit diagram
</details>


<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

    // S1-T1
    // Reed Solomon Codes

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


---
### Test bench File

    // First testcase

    module testbench1;

    // Inputs for Vigenère cipher
    reg [3:0] key; // 4-bit key
    reg [3:0] data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, data_in6, data_in7;
    wire [3:0] enc_data_out0, enc_data_out1, enc_data_out2, enc_data_out3;
    wire [3:0] enc_data_out4, enc_data_out5, enc_data_out6, enc_data_out7;


    // Inputs for Lagrange interpolation
    reg [15:0] test_y1, test_y2, test_y3, test_y4;
    reg [15:0] test_y5, test_y6, test_y7, test_y8;
    reg [3:0] test_x;
    wire [15:0] test_y;

    // Inputs for data transfer
    reg clk;
    reg[3:0] transfer1, transfer2, transfer3, transfer4,transfer5;
    reg[3:0] transfer6, transfer7, transfer8, transfer9, transfer10, transfer11, transfer12;
    reg[11:0] data_clocks;

    // Outputs for data transfer
    wire [3:0] data_out0, data_out1, data_out2, data_out3, data_out4, data_out5;
    wire [3:0] data_out6, data_out7, data_out8, data_out9, data_out10, data_out11; // 12 outputs
    wire [2:0] lost_count; // 3-bit lost data count
    wire transfer_failed; // Output for data transfer failure

    // Lagrange interpolation2
    reg [15:0] test_y1_2, test_y2_2, test_y3_2, test_y4_2;
    reg [15:0] test_y5_2, test_y6_2, test_y7_2, test_y8_2;
    reg [3:0] test_x_2;
    wire [15:0] test_y_2;

    // Decrypt Vignere cipher
    reg [3:0] decrypt_in0, decrypt_in1, decrypt_in2, decrypt_in3, decrypt_in4, decrypt_in5, decrypt_in6, decrypt_in7;
    wire [3:0] final0, final1, final2, final3, final4, final5, final6, final7;

    // Comparator 
    wire equal;

    // Instantiate the Vigenère cipher module
    encypt_vigenere_cipher vigenere (
        .key(key),
        .data_in0(data_in0),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_in4(data_in4),
        .data_in5(data_in5),
        .data_in6(data_in6),
        .data_in7(data_in7),
        .data_out0(enc_data_out0),
        .data_out1(enc_data_out1),
        .data_out2(enc_data_out2),
        .data_out3(enc_data_out3),
        .data_out4(enc_data_out4),
        .data_out5(enc_data_out5),
        .data_out6(enc_data_out6),
        .data_out7(enc_data_out7)
    );

    // Instantiate the Lagrange interpolation module
    lagrange_interpolation uut (
        .y1(test_y1),
        .y2(test_y2),
        .y3(test_y3),
        .y4(test_y4),
        .y5(test_y5),
        .y6(test_y6),
        .y7(test_y7),
        .y8(test_y8),
        .x_input(test_x),
        .y_output(test_y)
    );

    // Instantiate the data transfer module
    data_transfer_with_counter send (
        .clk(clk),
        .data_in0(transfer1), .data_in1(transfer2), .data_in2(transfer3), .data_in3(transfer4),
        .data_in4(transfer5), .data_in5(transfer6), .data_in6(transfer7), .data_in7(transfer8),
        .data_in8(transfer9), .data_in9(transfer10), .data_in10(transfer11), .data_in11(transfer12),
        .data_clocks(data_clocks), // Clock for each data input
        .data_out0(data_out0), .data_out1(data_out1), .data_out2(data_out2), .data_out3(data_out3),
        .data_out4(data_out4), .data_out5(data_out5), .data_out6(data_out6), .data_out7(data_out7),
        .data_out8(data_out8), .data_out9(data_out9), .data_out10(data_out10), .data_out11(data_out11),
        .lost_count(lost_count),
        .transfer_failed(transfer_failed)
    );

    // Instantiate the Lagrange interpolation module
    lagrange_interpolation2 receive (
        .y1(test_y1_2),
        .y2(test_y2_2),
        .y3(test_y3_2),
        .y4(test_y4_2),
        .y5(test_y5_2),
        .y6(test_y6_2),
        .y7(test_y7_2),
        .y8(test_y8_2),
        .x_input(test_x_2),
        .y_output(test_y_2)
    );

    // Instantiate the Vigenere cipher decryption module
    decrypt_vigenere_cipher decrypt (
        .key(key),
        .data_in0(decrypt_in0),
        .data_in1(decrypt_in1),
        .data_in2(decrypt_in2),
        .data_in3(decrypt_in3),
        .data_in4(decrypt_in4),
        .data_in5(decrypt_in5),
        .data_in6(decrypt_in6),
        .data_in7(decrypt_in7),
        .data_out0(final0),
        .data_out1(final1),
        .data_out2(final2),
        .data_out3(final3),
        .data_out4(final4),
        .data_out5(final5),
        .data_out6(final6),
        .data_out7(final7)
    );

    comparator_8x4 compare (
    .A0(data_in0), 
    .A1(data_in1), 
    .A2(data_in2), 
    .A3(data_in3), 
    .A4(data_in4), 
    .A5(data_in5), 
    .A6(data_in6), 
    .A7(data_in7),
    .B0(final0), 
    .B1(final1), 
    .B2(final2), 
    .B3(final3), 
    .B4(final4), 
    .B5(final5), 
    .B6(final6), 
    .B7(final7),
    .equal(equal)
    );

    // Global clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Initialize inputs and run the test
    initial begin
        key = 4'b0101; // Key for Vigenere cipher

        // Initialize data inputs
        data_in0 = 4'b0010; data_in1 = 4'b0010; data_in2 = 4'b0011; data_in3 = 4'b0011;
        data_in4 = 4'b0100; data_in5 = 4'b0100; data_in6 = 4'b0101; data_in7 = 4'b0101;

        $display("-------------------------------------------------------");
        $display("\t\t First Testcase");
        $display("-------------------------------------------------------");

        // display the inputs
        $display(" ");
        $display("Message to be sent: ");
        $display(" ");

        $display("Data 1: %b",data_in0);
        $display("Data 2: %b",data_in1);
        $display("Data 3: %b",data_in2);
        $display("Data 4: %b",data_in3);
        $display("Data 5: %b",data_in4);
        $display("Data 6: %b",data_in5);
        $display("Data 7: %b",data_in6);
        $display("Data 8: %b",data_in7);


        #10; 
        // display the encrypted data
        $display(" ");
        $display("Applying Vignere cipher encryption... ");
        $display(" ");
        $display("Encrypted messgae: ");
        $display(" ");

        $display("Encrypted Data 1: %b",enc_data_out0);
        $display("Encrypted Data 2: %b",enc_data_out1);
        $display("Encrypted Data 3: %b",enc_data_out2);
        $display("Encrypted Data 4: %b",enc_data_out3);
        $display("Encrypted Data 5: %b",enc_data_out4);
        $display("Encrypted Data 6: %b",enc_data_out5);
        $display("Encrypted Data 7: %b",enc_data_out6);
        $display("Encrypted Data 8: %b",enc_data_out7);

    end

    initial begin

        // Wait for some cycles to observe outputs
        #200;        

        test_y1 = {12'b0, enc_data_out0}; 
        test_y2 = {12'b0, enc_data_out1};
        test_y3 = {12'b0, enc_data_out2};
        test_y4 = {12'b0, enc_data_out3};
        test_y5 = {12'b0, enc_data_out4};
        test_y6 = {12'b0, enc_data_out5};
        test_y7 = {12'b0, enc_data_out6};
        test_y8 = {12'b0, enc_data_out7};

        $display(" ");
        $display("Lagrange interpolation applied");

        // // Monitor outputs for each input from 1 to 8
        // for (test_x = 4'd1; test_x <= 4'd11; test_x = test_x + 1) begin
        //     #10; // Wait for a short time to allow output to settle
        //     $monitor("At time %t: Input X=%d => Output Y=%d", $time, test_x, test_y);
        // end
        
    end

    initial begin
        // Initialize inputs and clocks

        #500
        transfer1 = {4'b0, test_y1}; 
        transfer2 = {4'b0, test_y2};  
        transfer3 = {4'b0, test_y3};  
        transfer4 = {4'b0, test_y4}; 
        transfer5 = {4'b0, enc_data_out4};  
        transfer6 = {4'b0, enc_data_out5};  
        transfer7 = {4'b0, enc_data_out6};  
        transfer8 = {4'b0, enc_data_out7}; 
        transfer9 = {4'b0, test_y5};  
        transfer10 = {4'b0, test_y6};  
        transfer11 = {4'b0, test_y7};  
        transfer12 = {4'b0, test_y8}; 

        // Clock signals for data inputs 
        data_clocks = 12'b111100001111; 

        // Wait for a few clock cycles and observe outputs
        #200;

        $display(" ");
        $display("Data sent by the Transmitter");
        $display(" ");
        #50;
        $display("Data Received by the Receiver: ");
        $display(" ");

        $display("Received message: ");
        $display(" ");

        $display("Data 1: %b",data_out0);
        $display("Data 2: %b",data_out1);
        $display("Data 3: %b",data_out2);
        $display("Data 4: %b",data_out3);
        $display("Data 5: %b",data_out4);
        $display("Data 6: %b",data_out5);
        $display("Data 7: %b",data_out6);
        $display("Data 8: %b",data_out7);

        $display(" ");
        $display("Lost count: %d", lost_count);
        $display("Transfer failed: %b",transfer_failed);

        if(transfer_failed == 1'b1) begin
            $display("According to Reed Solomon codes, cannot recover the data since more than 50 percent of the data is lost");
            $display(" ");
            $finish;
        end

        #100;
        
    end    

    initial begin
        #1000;        

        test_y1_2 = {12'b0, data_out0}; 
        test_y2_2 = {12'b0, data_out1};
        test_y3_2 = {12'b0, data_out2};
        test_y4_2 = {12'b0, data_out3};
        test_y5_2 = {12'b0, data_out8};
        test_y6_2 = {12'b0, data_out9};
        test_y7_2 = {12'b0, data_out10};
        test_y8_2 = {12'b0, data_out11};

        $display(" ");
        $display("Applying lagrange interpolation to recover lost data...");
        $display(" ");

        // // Monitor outputs for each input from 1 to 8
        // for (test_x = 4'd1; test_x <= 4'd11; test_x = test_x + 1) begin
        //     #10; // Wait for a short time to allow output to settle
        //     $monitor("At time %t: Input X=%d => Output Y=%d", $time, test_x, test_y);
        // end
        
    end

    initial begin

        #1500;

        decrypt_in0 = {4'b0, test_y1_2}; 
        decrypt_in1 = {4'b0, test_y2_2}; 
        decrypt_in2 = {4'b0, test_y3_2}; 
        decrypt_in3 = {4'b0, test_y4_2}; 
        decrypt_in4 = {4'b0, test_y5_2}; 
        decrypt_in5 = {4'b0, test_y6_2}; 
        decrypt_in6 = {4'b0, test_y7_2}; 
        decrypt_in7 = {4'b0, test_y8_2}; 

        #100; 

        
        $display(" ");
        $display("Lost data recovered! ");
        $display(" ");
        $display("Recovered data: ");
        $display(" ");

        $display("Data 1: %b",decrypt_in0);
        $display("Data 2: %b",decrypt_in1);
        $display("Data 3: %b",decrypt_in2);
        $display("Data 4: %b",decrypt_in3);
        $display("Data 5: %b",decrypt_in4);
        $display("Data 6: %b",decrypt_in5);
        $display("Data 7: %b",decrypt_in6);
        $display("Data 8: %b",decrypt_in7);

        #100;

        $display(" ");
        $display("Decrypting received message...");
        $display(" ");

        $display("Final decrypted message: ");
        $display(" ");

        $display("Data 1: %b",final0);
        $display("Data 2: %b",final1);
        $display("Data 3: %b",final2);
        $display("Data 4: %b",final3);
        $display("Data 5: %b",final4);
        $display("Data 6: %b",final5);
        $display("Data 7: %b",final6);
        $display("Data 8: %b",final7);

    end

    initial begin
        #2500;
        $display(" ");
        $display("Does the received output match the message sent? : %b", equal); 
        $display(" ");
    
    end
    
    // Finish simulation
    initial begin 
        #5000;
        $finish;
    end
    
    endmodule
    
    
    // Second testcase
    
    module testbench2;
    
    // Inputs for Vigenère cipher
    reg [3:0] key; // 4-bit key
    reg [3:0] data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, data_in6, data_in7;
    wire [3:0] enc_data_out0, enc_data_out1, enc_data_out2, enc_data_out3;
    wire [3:0] enc_data_out4, enc_data_out5, enc_data_out6, enc_data_out7;


    // Inputs for Lagrange interpolation
    reg [15:0] test_y1, test_y2, test_y3, test_y4;
    reg [15:0] test_y5, test_y6, test_y7, test_y8;
    reg [3:0] test_x;
    wire [15:0] test_y;

    // Inputs for data transfer
    reg clk;
    reg[3:0] transfer1, transfer2, transfer3, transfer4,transfer5;
    reg[3:0] transfer6, transfer7, transfer8, transfer9, transfer10, transfer11, transfer12;
    reg[11:0] data_clocks;

    // Outputs for data transfer
    wire [3:0] data_out0, data_out1, data_out2, data_out3, data_out4, data_out5;
    wire [3:0] data_out6, data_out7, data_out8, data_out9, data_out10, data_out11; // 12 outputs
    wire [2:0] lost_count; // 3-bit lost data count
    wire transfer_failed; // Output for data transfer failure

    // Lagrange interpolation2
    reg [15:0] test_y1_2, test_y2_2, test_y3_2, test_y4_2;
    reg [15:0] test_y5_2, test_y6_2, test_y7_2, test_y8_2;
    reg [3:0] test_x_2;
    wire [15:0] test_y_2;

    // Decrypt Vignere cipher
    reg [3:0] decrypt_in0, decrypt_in1, decrypt_in2, decrypt_in3, decrypt_in4, decrypt_in5, decrypt_in6, decrypt_in7;
    wire [3:0] final0, final1, final2, final3, final4, final5, final6, final7;

    // comparator 
    wire equal;

    // Instantiate the Vigenère cipher module
    encypt_vigenere_cipher vigenere (
        .key(key),
        .data_in0(data_in0),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_in4(data_in4),
        .data_in5(data_in5),
        .data_in6(data_in6),
        .data_in7(data_in7),
        .data_out0(enc_data_out0),
        .data_out1(enc_data_out1),
        .data_out2(enc_data_out2),
        .data_out3(enc_data_out3),
        .data_out4(enc_data_out4),
        .data_out5(enc_data_out5),
        .data_out6(enc_data_out6),
        .data_out7(enc_data_out7)
    );

    // Instantiate the Lagrange interpolation module
    lagrange_interpolation uut (
        .y1(test_y1),
        .y2(test_y2),
        .y3(test_y3),
        .y4(test_y4),
        .y5(test_y5),
        .y6(test_y6),
        .y7(test_y7),
        .y8(test_y8),
        .x_input(test_x),
        .y_output(test_y)
    );

    // Instantiate the data transfer module
    data_transfer_with_counter send (
        .clk(clk),
        .data_in0(transfer1), .data_in1(transfer2), .data_in2(transfer3), .data_in3(transfer4),
        .data_in4(transfer5), .data_in5(transfer6), .data_in6(transfer7), .data_in7(transfer8),
        .data_in8(transfer9), .data_in9(transfer10), .data_in10(transfer11), .data_in11(transfer12),
        .data_clocks(data_clocks), 
        .data_out0(data_out0), .data_out1(data_out1), .data_out2(data_out2), .data_out3(data_out3),
        .data_out4(data_out4), .data_out5(data_out5), .data_out6(data_out6), .data_out7(data_out7),
        .data_out8(data_out8), .data_out9(data_out9), .data_out10(data_out10), .data_out11(data_out11),
        .lost_count(lost_count),
        .transfer_failed(transfer_failed)
    );

    // Instantiate the Lagrange interpolation module
    lagrange_interpolation2 receive (
        .y1(test_y1_2),
        .y2(test_y2_2),
        .y3(test_y3_2),
        .y4(test_y4_2),
        .y5(test_y5_2),
        .y6(test_y6_2),
        .y7(test_y7_2),
        .y8(test_y8_2),
        .x_input(test_x_2),
        .y_output(test_y_2)
    );

    // Instantiate the Vigenère cipher decryption module
    decrypt_vigenere_cipher decrypt (
        .key(key),
        .data_in0(decrypt_in0),
        .data_in1(decrypt_in1),
        .data_in2(decrypt_in2),
        .data_in3(decrypt_in3),
        .data_in4(decrypt_in4),
        .data_in5(decrypt_in5),
        .data_in6(decrypt_in6),
        .data_in7(decrypt_in7),
        .data_out0(final0),
        .data_out1(final1),
        .data_out2(final2),
        .data_out3(final3),
        .data_out4(final4),
        .data_out5(final5),
        .data_out6(final6),
        .data_out7(final7)
    );

    comparator_8x4 compare (
    .A0(data_in0), 
    .A1(data_in1), 
    .A2(data_in2), 
    .A3(data_in3), 
    .A4(data_in4), 
    .A5(data_in5), 
    .A6(data_in6), 
    .A7(data_in7),
    .B0(final0), 
    .B1(final1), 
    .B2(final2), 
    .B3(final3), 
    .B4(final4), 
    .B5(final5), 
    .B6(final6), 
    .B7(final7),
    .equal(equal)
    );

    // Global clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Initialize inputs and run the test
    initial begin
        #3000;
        key = 4'b0110; // Key for Vigenere cipher

        // Initialize data inputs
        data_in0 = 4'b0010; data_in1 = 4'b0010; data_in2 = 4'b0011; data_in3 = 4'b0011;
        data_in4 = 4'b0100; data_in5 = 4'b0100; data_in6 = 4'b0101; data_in7 = 4'b0101;

        $display(" ");
        $display("-------------------------------------------------------");
        $display("\t\t Second Testcase");
        $display("-------------------------------------------------------");

        // display the inputs
        $display(" ");
        $display("Message to be sent: ");
        $display(" ");

        $display("Data 1: %b",data_in0);
        $display("Data 2: %b",data_in1);
        $display("Data 3: %b",data_in2);
        $display("Data 4: %b",data_in3);
        $display("Data 5: %b",data_in4);
        $display("Data 6: %b",data_in5);
        $display("Data 7: %b",data_in6);
        $display("Data 8: %b",data_in7);


        #10; 
        // display the encrypted data
        $display(" ");
        $display("Applying Vignere cipher encryption... ");
        $display(" ");
        $display("Encrypted messgae: ");
        $display(" ");

        $display("Encrypted Data 1: %b",enc_data_out0);
        $display("Encrypted Data 2: %b",enc_data_out1);
        $display("Encrypted Data 3: %b",enc_data_out2);
        $display("Encrypted Data 4: %b",enc_data_out3);
        $display("Encrypted Data 5: %b",enc_data_out4);
        $display("Encrypted Data 6: %b",enc_data_out5);
        $display("Encrypted Data 7: %b",enc_data_out6);
        $display("Encrypted Data 8: %b",enc_data_out7);

    end

    initial begin

        // Wait for some cycles to observe outputs
        #3500;        

        test_y1 = {12'b0, enc_data_out0}; 
        test_y2 = {12'b0, enc_data_out1};
        test_y3 = {12'b0, enc_data_out2};
        test_y4 = {12'b0, enc_data_out3};
        test_y5 = {12'b0, enc_data_out4};
        test_y6 = {12'b0, enc_data_out5};
        test_y7 = {12'b0, enc_data_out6};
        test_y8 = {12'b0, enc_data_out7};

        $display(" ");
        $display("Lagrange interpolation applied");

        // // Monitor outputs for each input from 1 to 8
        // for (test_x = 4'd1; test_x <= 4'd11; test_x = test_x + 1) begin
        //     #10; // Wait for a short time to allow output to settle
        //     $monitor("At time %t: Input X=%d => Output Y=%d", $time, test_x, test_y);
        // end
        
    end

    initial begin

        // Initialize inputs and clocks

        #4000;
        transfer1 = {4'b0, test_y1}; 
        transfer2 = {4'b0, test_y2};  
        transfer3 = {4'b0, test_y3};  
        transfer4 = {4'b0, test_y4}; 
        transfer5 = {4'b0, enc_data_out4};  
        transfer6 = {4'b0, enc_data_out5};  
        transfer7 = {4'b0, enc_data_out6};  
        transfer8 = {4'b0, enc_data_out7}; 
        transfer9 = {4'b0, test_y5};  
        transfer10 = {4'b0, test_y6};  
        transfer11 = {4'b0, test_y7};  
        transfer12 = {4'b0, test_y8}; 

        // Clock signals for data inputs 
        data_clocks = 12'b111100001101; 

        // Wait for a few clock cycles and observe outputs
        #200;

        $display(" ");
        $display("Data sent.");
        $display(" ");
        #50;
        $display("Data Received: ");
        $display(" ");

        $display("Received message: ");
        $display(" ");

        $display("Data 1: %b",data_out0);
        $display("Data 2: %b",data_out1);
        $display("Data 3: %b",data_out2);
        $display("Data 4: %b",data_out3);
        $display("Data 5: %b",data_out4);
        $display("Data 6: %b",data_out5);
        $display("Data 7: %b",data_out6);
        $display("Data 8: %b",data_out7);

        $display(" ");
        $display("Lost count: %d", lost_count);
        $display("Transfer failed: %b",transfer_failed);

        if(transfer_failed == 1'b1) begin
            $display("According to Reed Solomon codes, cannot recover the data since more than 50 percent of the data is lost");
            $display(" ");
            $finish;
        end

        #100;
        
    end    

    initial begin
        #4500;        

        test_y1_2 = {12'b0, data_out0}; 
        test_y2_2 = {12'b0, data_out1};
        test_y3_2 = {12'b0, data_out2};
        test_y4_2 = {12'b0, data_out3};
        test_y5_2 = {12'b0, data_out8};
        test_y6_2 = {12'b0, data_out9};
        test_y7_2 = {12'b0, data_out10};
        test_y8_2 = {12'b0, data_out11};

        $display(" ");
        $display("Applying lagrange interpolation to recover lost data...");
        $display(" ");

        // // Monitor outputs for each input from 1 to 8
        // for (test_x = 4'd1; test_x <= 4'd11; test_x = test_x + 1) begin
        //     #10; // Wait for a short time to allow output to settle
        //     $monitor("At time %t: Input X=%d => Output Y=%d", $time, test_x, test_y);
        // end
        
    end

    initial begin

        #5000;

        decrypt_in0 = {4'b0, test_y1_2}; 
        decrypt_in1 = {4'b0, test_y2_2}; 
        decrypt_in2 = {4'b0, test_y3_2}; 
        decrypt_in3 = {4'b0, test_y4_2}; 
        decrypt_in4 = {4'b0, test_y5_2}; 
        decrypt_in5 = {4'b0, test_y6_2}; 
        decrypt_in6 = {4'b0, test_y7_2}; 
        decrypt_in7 = {4'b0, test_y8_2}; 

        #100; 

        
        $display(" ");
        $display("Lost data recovered! ");
        $display(" ");
        $display("Recovered data: ");
        $display(" ");

        $display("Data 1: %b",decrypt_in0);
        $display("Data 2: %b",decrypt_in1);
        $display("Data 3: %b",decrypt_in2);
        $display("Data 4: %b",decrypt_in3);
        $display("Data 5: %b",decrypt_in4);
        $display("Data 6: %b",decrypt_in5);
        $display("Data 7: %b",decrypt_in6);
        $display("Data 8: %b",decrypt_in7);

        #100;

        $display(" ");
        $display("Decrypting received message...");
        $display(" ");

        $display("Final decrypted message: ");
        $display(" ");

        $display("Data 1: %b",final0);
        $display("Data 2: %b",final1);
        $display("Data 3: %b",final2);
        $display("Data 4: %b",final3);
        $display("Data 5: %b",final4);
        $display("Data 6: %b",final5);
        $display("Data 7: %b",final6);
        $display("Data 8: %b",final7);

    end

    initial begin
        #5500;
        $display(" ");
        $display("Does the received output match the message sent? : %b", equal); 
        $display(" ");
    
    end
    
    // Finish simulation
    initial begin 
        #6000;
        $finish;
    end
    
    endmodule

</details>


