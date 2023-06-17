module subtractor(input [7:0] A,
input [7:0] B,
output [7:0] result,
output borrow
);
assign result=A>B?A-B:B-A;
assign borrow=A>B?0:1;
endmodule

module rightShifter(input [23:0] A,
input [7:0]shiftAmount,
output [23:0]rshout
);

assign rshout=A>>shiftAmount;

endmodule

module mux2by1(input [22:0] A,
input [22:0] B,
input borrow,
output [23:0]muxout
);
assign muxout=(borrow==0)?{1'b1,B}:{1'b1,A};

endmodule

module signDecider(input x,
input y,
input [7:0]expA,
input [7:0]expB,
output reg signout
);
always @(*)
begin
    if(x==0&&y==0)
    signout=0;
    else if(x==1&&y==1)
    signout=1;
    else
    signout=(expA>expB)?x:y;
end

endmodule

module mux2by1_8(input [7:0] A,
input [7:0] B,
input borrow,
output [7:0]muxout2
);
assign muxout2=(borrow==1)?B:A;

endmodule

module ControlledIncrementor(cout,exp,manta, outExp,outMant); 
input cout;
input [7:0] exp;
input [24:0] manta;

output reg [7:0] outExp;
output reg [23:0] outMant;
always @(*) begin
if(cout)//  0010.00110100    * 10^5
    begin
        outMant = manta>>1;
        outExp = exp+1'b1;
    end
else
    begin
        outMant = manta;
        outExp = exp;
    while(!outMant[23] && outMant != 0)
        begin
           outMant = outMant<<1;
           outExp =  outExp-1'b1;
        end
    end
end
endmodule


module FPA (input [31:0] A,
input [31:0] B,
input OF,
output [31:0] sum
);
wire [22:0]manticaA; wire [22:0]manticaB;
wire [7:0]expA; wire [7:0]expB;
wire [7:0]shiftAmount;
wire borrow;
wire [31:0]Acomplement;
wire [23:0]firstOp;
wire [23:0]secondOp;
wire [23:0]secondOp2;
wire [23:0]firstOpShifted;
wire [23:0]secondOpConcatinated;
wire [23:0] add1, add2;
assign manticaA[22:0]=A[22:0];
assign manticaB[22:0]=B[22:0];
assign expA = A[30:23];
assign expB = B[30:23];
wire [31:0]manticaSum;
wire manticaCout;
wire manticaOF;
//wire [22:0]manticaA2;
//wire [22:0]manticaB2;
wire [7:0]final_exponential_output;
subtractor s1(expA,expB,shiftAmount,borrow);
mux2by1 m1(manticaA,manticaB,borrow,firstOp);
mux2by1 m2(manticaB,manticaA,borrow,secondOp);
rightShifter rsh1(firstOp,shiftAmount,firstOpShifted);

assign add1 = (firstOpShifted >= secondOp)? firstOpShifted : secondOp;
assign add2 = (firstOpShifted >= secondOp)? secondOp : firstOpShifted;

//assign secondOpConcatinated={1'b1,secondOp};

assign secondOp2=(A[31]^B[31])?((add2 ^ 24'hffffff)+1'b1):add2;
// assign {max, }=(A[31]^B[31])?((~secondOp)+1):secondOp;

// assign manticaA2 = ((A[31]^B[31])&&(A[31]==1))?~manticaA+1:manticaA;
// assign manticaB2 = ((A[31]^B[31])&&(B[31]==1))?~manticaB+1:manticaB;

carry_lookahead_adder_32_bit CLA({1'b0,add1},{1'b0,secondOp2},manticaSum,manticaCout,manticaOF);
mux2by1_8 m22(expA,expB,borrow,final_exponential_output);

wire c;
wire [7:0]outExp;
wire [23:0] outMant;
assign c=manticaSum[24];



ControlledIncrementor CI(c,final_exponential_output,manticaSum[24:0], outExp,outMant);

wire sign;
signDecider sd(A[31],B[31],expA,expB,sign);
assign sum={sign,outExp,outMant[22:0]}+1;
assign OF= (outExp==255)?1:0;
endmodule