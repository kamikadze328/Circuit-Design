`timescale 1ns / 1ps

module test_sqrt();
    reg [31:0] x;
    wire [31:0] result;

    sqrt sqrt_module (
        .x(x),
        .y(result)
    );
     
    initial begin
        x=32'hffffffff; #3 //sqrt(4 294 967 295)
        $display("%h should be ffff", result);
        
        x=32'hfffe0001; #3 //sqrt(4 294 836 225)
        $display("%h should be ffff", result);
        
        x=32'hfffe0000; #3 //sqrt(4 294 836 224)
        $display("%h should be fffe", result); 
        
        x=32'hfffeffff; #3 //sqrt(4 294 836 224)
        $display("%h should be fffe", result); 
        
        x=32'hfffa0009; #3 //sqrt(4 294 574 089)
        $display("%h should be fffd", result); 
        
        x='b0; #3 //sqrt(0)
        $display("%h should be 0", result); 
        
        x=32'h00000001; #3 //sqrt(1)
        $display("%h should be 1", result);
        
        x=32'h00000004; #3 //sqrt(4)
        $display("%h should be 2", result); 
    end
    
endmodule
