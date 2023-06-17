module tb_fp;
  wire [31:0] sum;
  wire OF;
  reg [31:0] a, b;
  integer successful_tests;
  integer failed_tests;
  
FPA fpa (a,b,OF,sum);
  
  initial
  begin
    //$monitor("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);
    successful_tests = 0;
    failed_tests = 0;
  end
  
  initial
begin
    // 1.2+12.4=13.6
    a=32'b00111111100110011001100110011010; b=32'b01000001010001100110011001100110;
    #10
    if (sum == 32'b01000001010110011001100110011010)begin
        $display("Test#1:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#1:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);

//0.8+0.7=1.5
    a='b00111111010011001100110011001101; b='b00111111001100110011001100110011;
    #10 if (sum == 32'b00111111110000000000000000000001)begin
        $display("Test#2:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#2:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);

//-0.3+-11.7=-12.0
    a='b10111110100110011001100110011010; b='b11000001001110110011001100110011;
    #10 if (sum == 32'b11000001010000000000000000000000) begin
        $display("Test#3:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#3:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);


//-15.9+1.3=-14.6
    a='b11000001011111100110011001100110; b='b00111111101001100110011001100110;
    #10 if (sum == 32'b11000001011010011001100110011010)  begin
        $display("Test#4:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#4:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end
    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);


//-18.7+10.11=-8.59
    a='b11000001100101011001100110011010; b='b01000001001000011100001010001111;
    #10 if (sum == 32'b1_10000010_00010010111000010100100)  
    begin
        $display("Test#5:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#5:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);
//11.4+7.18=18.58
    a='b01000001001101100110011001100110; b='b01000000111001011100001010001111;
    #10 if (sum == 32'b01000001100101001010001111010111) 
    begin
        $display("Test#6:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#6:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);

//-10.2-11.5=-21.7
    a='b11000001001000110011001100110011; b='b11000001001110000000000000000000;
    #10 if (sum == 32'b11000001101011011001100110011010)  
    begin
        $display("Test#7:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#7:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);

//-7.7-0.6=-8.3
    a='b11000000111101100110011001100110; b='b10111111000110011001100110011010;
    #10 if (sum == 32'b11000001000001001100110011001101)  
    begin
        $display("Test#8:success");
        successful_tests=successful_tests+1;
    end else begin
	    $display("Test#8:failed with input %b and %b and Output %b and overflow status %b",a,b,sum,OF);
        failed_tests= failed_tests+1;
    end

    $display("A= %b|B= %b|Sum%b|OverFlow=%b", a[31:0], b[31:0], sum[31:0],OF);


    $display("Testbench ended with %d successful testcases and %d failed tests",successful_tests,failed_tests);


   // #10 a='b1000001111111110000111100111101; b='b00001111000011111111111111111111;cin = 0;
   // #10 a='b11011111111111111110100011001010; b='b11001111111111111111100011001010;

end
endmodule

