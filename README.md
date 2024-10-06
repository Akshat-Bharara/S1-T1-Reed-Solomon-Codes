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
- https://en.wikipedia.org/wiki/Voyager_2<br>
- https://www.youtube.com/watch?v=1pQJkt7-R4Q<br>
- https://www.youtube.com/watch?v=6X1OCX-iq9w
  
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary>
  ![S1-T1-functional-block-diagram](https://github.com/user-attachments/assets/2d5d6955-57a3-4408-9581-c3350bba5869)

</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

  > Explain the working of your model with the help of a functional table (compulsory) followed by the flowchart.
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

  > Neatly update the Verilog code in code style only.
</details>


