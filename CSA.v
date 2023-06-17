
// Full Adder
module FA(output sum, cout, input a, b, cin);
  wire w0, w1, w2;
  
  xor (w0, a, b);
  xor (sum, w0, cin);
  
  and (w1, w0, cin);
  and (w2, a, b);
  or (cout, w1, w2);
endmodule

// Ripple Carry Adder - 4 bits
module RCA4(output [3:0] sum, output cout, input [3:0] a, b, input cin);
  
  wire [3:1] c;
  
  FA fa0(sum[0], c[1], a[0], b[0], cin);
  FA fa[2:1](sum[2:1], c[3:2], a[2:1], b[2:1], c[2:1]);
  FA fa31(sum[3], cout, a[3], b[3], c[3]);
  
endmodule

module SkipLogic(output cin_next,
  input [3:0] a, b, input cin, cout);
  
  wire p0, p1, p2, p3, P, e;
  
  or (p0, a[0], b[0]);
  or (p1, a[1], b[1]);
  or (p2, a[2], b[2]);
  or (p3, a[3], b[3]);
  
  and (P, p0, p1, p2, p3);
  and (e, P, cin);
  
  or (cin_next, e, cout);

endmodule

// Carry Skip Adder - 32 bits
module CSkipA32(output [31:0] sum, output cout, input [31:0] a,input cin,input [31:0] b,output OF);
  wire ofPositive, ofNegative;
  wire [7:0] couts;
  wire [6:0] e;
  
  RCA4 rca0(sum[3:0], couts[0], a[3:0], b[3:0], cin);
  RCA4 rca[7:1](sum[31:4], couts[7:1], a[31:4], b[31:4], e[6:0]);
  
  SkipLogic skip0(e[0], a[3:0], b[3:0], 0, couts[0]);
  SkipLogic skip[6:1](e[6:1], a[27:4], b[27:4], e[5:0], couts[6:1]);
  SkipLogic skip7(cout, a[31:28], b[31:24], e[6], couts[7]);
  assign ofPositive = sum[31]^ (~a[31]) ^ (~b[31]);
  assign ofNegative = (~sum[31]) ^ (a[31]) ^ (b[31]);
  assign OF = ofPositive | ofNegative;
endmodule
