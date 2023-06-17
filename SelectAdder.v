module carry_select_adder
        (   input [31:0] A,B,
            input cin,
            output [31:0] S,
            output cout,
            output OF
            );
        

wire [30:0] temp0,temp1,carry0,carry1;
wire ofPositive, ofNegative,carry;

fulladder fa0(A[0],B[0],cin,S[0],carry);
                              //////////////////////////////////////////////////////////////////////////
//for carry 0
fulladder fa00(A[1],B[1],1'b0,temp0[0],carry0[0]);
genvar i;

generate
for(i=2;i<32;i=i+1)
begin
fulladder fa0(A[i],B[i],carry0[i-2],temp0[i-1],carry0[i-1]);
end
endgenerate


//for carry 1

fulladder fa10(A[1],B[1],1'b1,temp1[0],carry1[0]);

genvar j;
generate
for(j=2;j<32;j=j+1)
begin
fulladder fa1(A[j],B[j],carry1[j-2],temp1[j-1],carry1[j-1]);
end
endgenerate

//mux for carry
multiplexer2 mux_carry(carry0[30],carry1[30],carry,cout);

//mux's for sum
genvar k;

generate
for(k=0;k<31;k=k+1)
begin
multiplexer2 mux_sum(temp0[k],temp1[k],carry,S[k+1]);
end
endgenerate

 assign ofPositive = S[31]& (~A[31]) & (~B[31]);
 assign ofNegative = (~S[31]) & (A[31]) & (B[31]);
 assign OF = ofPositive | ofNegative;

endmodule 
