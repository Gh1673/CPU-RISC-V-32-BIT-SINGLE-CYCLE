
module ALU(
	   input wire signed [31:0]  A,B,  
	   input wire signed [3:0]   ALUControl,
	   output wire signed	      Zero,
	   output wire signed [31:0] Result );

   reg [31:0]		      ResultReg;
   wire [31:0]		      temp,Sum;
   wire			      V,slt, sltu; //overflow
   assign temp = ALUControl[0] ? ~B:B;
   assign Sum = A + temp + ALUControl[0]; 
   assign V = (ALUControl[0]) ? 
              (~(A[31] ^ B[31]) & (A[31] ^ Sum[31])) :  
              ((A[31] ^ B[31]) & (~(A[31] ^ Sum[31])));  
   assign slt = (A[31] == B[31]) ? (A < B) : A[31];     always@(*)
     case(ALUControl)
       4'b0000: ResultReg <= Sum; //add
       4'b0001: ResultReg <= Sum; //sub
       4'b0010: ResultReg <= A&B; //and
       4'b0011: ResultReg <= A|B; //or
       4'b0100: ResultReg <= A^B; //xor     
       4'b0101: ResultReg <= {31'b0,slt}; //slt
       4'b0110: ResultReg <= {31'b0,sltu}; // sltu
       4'b0111: ResultReg <= {A[31:12],12'b0}; //lui
       4'b1000: ResultReg <= A + {B[31:12],12'b0}; // AUIPC
       4'b1001: ResultReg <= {B[31:12],12'b0}; // LUI
       
       4'b1010: ResultReg <= A << B; // sll, slli
       4'b1011: ResultReg <= A >>> B; // sra
       4'b1100: ResultReg <= A >> B; // srl
       //to add sll, slli,
       //to add sra
       default:  ResultReg <= 'bx;
     endcase
   assign Zero = (ResultReg == 32'b0);
   assign Result = ResultReg;

endmodule
