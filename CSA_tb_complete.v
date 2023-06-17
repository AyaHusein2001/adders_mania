module tb_CSkipA32;
  wire [31:0] sum;
  wire cout,OF;
  reg [31:0] a, b;
  reg cin;
  integer successful_tests;
  integer failed_tests;


  //CSkipA32 sca32(sum[31:0], cout, a[31:0],cin, b[31:0],OF);
  carry_select_adder select32(a,b,cin,sum,cout,OF);
 // carry_lookahead_adder_32_bit cla32(a,b,sum,cout,OF);

  initial
  begin
    //$monitor("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);
    successful_tests = 0;
    failed_tests = 0;
  end
  
  initial
begin
    
    a=32'b01011111111111111110100011001010; b=32'b01010100111101001111111111111111; cin = 0;
    #10
    if (sum == 32'b1011_0100_1111_0100_1110_1000_1100_1001)begin
        $display("Test#1:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#1:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);


    a='b10100000101000001111111111111111; b='b10100000101111111111111111100000;cin = 0;
    #10 if (sum == 32'b0100_0001_0110_0000_1111_1111_1101_1111)begin
        $display("Test#2:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#2:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);


    a='b10000000101000001111111111111111; b='b00100000101111111111111111100000;cin = 0;
    #10 if (sum == 32'b1010_0001_0110_0000_1111_1111_1101_1111) begin
        $display("Test#3:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#3:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);



    a='b00000000101000001110111111111111; b='b00100000101111111110111111100000;cin = 0;
    #10 if (sum == 32'b0010_0001_0110_0000_1101_1111_1101_1111)  begin
        $display("Test#4:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#4:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);



    a='b10000000101000001110111111111111; b='b10100000101111111110111111100000;cin = 0;
    #10 if (sum == 32'b0010_0001_0110_0000_1101_1111_1101_1111)  
    begin
        $display("Test#5:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#5:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);

    a='b01011000111111111111111111110100; b='b10010100111101001111111111111111;cin = 0;
    #10 if (sum == 32'b1110_1101_1111_0100_1111_1111_1111_0011) 
    begin
        $display("Test#6:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#6:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);


    a='b1000001111111110000111100111101; b='b00001111000011111111111111111111;cin = 0;
    #10 if (sum == 32'b0101_0001_0000_1111_0000_1111_0011_1100)  
    begin
        $display("Test#7:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#7:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);


    a='b11011111111111111110100011001010; b='b11001111111111111111100011001010;cin = 1;
    #10 if (sum == 32'b1010_1111_1111_1111_1110_0001_1001_0101)  
    begin
        $display("Test#8:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#8:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b||cout= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], cout, sum[31:0],OF);


    $display("Testbench ended with %d successful testcases and %d failed tests",successful_tests,failed_tests);


   // #10 a='b1000001111111110000111100111101; b='b00001111000011111111111111111111;cin = 0;
   // #10 a='b11011111111111111110100011001010; b='b11001111111111111111100011001010;

end
endmodule

