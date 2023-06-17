///////////////////////////////////////////////////////////////////////////////
// File Downloaded from http://www.nandland.com
///////////////////////////////////////////////////////////////////////////////

module full_adder 
            ( 
              input i_bit1,
              input i_bit2,
              input i_carry,
              output o_sum,
              output o_carry );


assign o_sum = i_bit1 ^ i_bit2 ^ i_carry;
assign o_carry = ((i_bit1 ^ i_bit2) & i_carry) | (i_bit1 & i_bit2);        
endmodule

module carry_lookahead_adder_32_bit 
  (
   input [31:0]  i_add1,
   input [31:0]  i_add2,
   output [31:0] o_result,
   output cout,OF
   );
     
  wire [32:0]    w_C;
  wire [31:0]    w_G, w_P, w_SUM;
   
wire ofPositive, ofNegative;

genvar i, j,k,t;

generate
for(i=0;i<32;i=i+1)
begin
 full_adder adderlook
    ( 
      .i_bit1(i_add1[i]),
      .i_bit2(i_add2[i]),
      .i_carry(w_C[i]),
      .o_sum(w_SUM[i]),
      .o_carry()
      );
end
endgenerate

   
  // Create the Generate (G) Terms:  Gi=Ai*Bi
for(j=0;j<32;j=j+1)
begin
  assign w_G[j] = i_add1[j] & i_add2[j];
end 
  // Create the Propagate Terms: Pi=Ai+Bi

for(k=0;k<32;k=k+1)
begin
 assign w_P[k] = i_add1[k] | i_add2[k];
end 

  // Create the Carry Terms:
  assign w_C[0] = 1'b0; // no carry input

for(t=1;t<33;t=t+1)
begin
 assign w_C[t] = w_G[t-1] | (w_P[t-1] & w_C[t-1]);
end 
 
  assign o_result = w_SUM;   // Verilog Concatenation
  assign cout=w_C[32];


 assign ofPositive = o_result[31]& (~i_add1[31]) & (~i_add2[31]);
 assign ofNegative = (~o_result[31]) & (i_add1[31]) & (i_add2[31]);
 assign OF = ofPositive | ofNegative;

endmodule // carry_lookahead_adder_4_bit
