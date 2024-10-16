// S1-T1-Reed-Solomon-Codes
// Data Recovery and Error Correction in Space Communication

// Gate level model

// Member-1: Akshat Bharara, Roll No: 231CS110
// Member-2: Dev Prajapati, Roll No: 231CS120
// Member-3: Vatsal Jay Gandhi, Roll No: 231CS164

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
        data_in0 = 4'b0010; data_in1 = 4'b0101; data_in2 = 4'b0100; data_in3 = 4'b0111;
        data_in4 = 4'b0110; data_in5 = 4'b0001; data_in6 = 4'b0000; data_in7 = 4'b0011;

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
