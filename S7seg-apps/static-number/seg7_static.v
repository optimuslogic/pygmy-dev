
module top (    
                //input [3:0] num_i, 
                 output leda,
                 output ledb,
                 output ledc,
             output ledd,
               output lede,
              output ledf,
               output ledg
                );

reg [6:0] gpio_out=7'b0001111;
 
                        
/*
always @(num_i)
begin
    case (num_i)   //case statement
        4'd0 : gpio_out = 7'b0000001;
        4'd1 : gpio_out = 7'b1001111;
        4'd2 : gpio_out = 7'b0010010;
        4'd3 : gpio_out = 7'b0000110;
        4'd4 : gpio_out = 7'b1001100;
        4'd5 : gpio_out = 7'b0100100;
        4'd6 : gpio_out = 7'b0100000;
        4'd7 : gpio_out = 7'b0001111;
        4'd8 : gpio_out = 7'b0000000;
        4'd9 : gpio_out = 7'b0000100;
        
        //switch off 7 segment character when the bcd digit is not a decimal number.
        default : gpio_out = 7'b1111111; 
    endcase
end
*/
assign {leda, ledb,ledc,ledd,lede,ledf,ledg}=gpio_out[6:0];



endmodule  
