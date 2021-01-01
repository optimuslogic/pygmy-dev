module helloworldfpga(
    output wire redled,
    output wire greenled,
    output wire blueled,
                output wire leda,
                 output wire ledb,
                 output wire ledc,
             output wire ledd,
               output wire lede,
              output wire ledf,
               output wire ledg
);
    wire clk;

    qlal4s3b_cell_macro u_qlal4s3b_cell_macro (
        .Sys_Clk0 (clk),
    );

    reg	[23:0]	cnt;
    reg	[23:0]	stopcnt;
    reg		led;
 	reg [6:0] gpio_out=7'b0001111;
    initial cnt <= 0;
    initial stopcnt <= 4000000;		// Change to 2000000
    initial led <= 0;

    always @(posedge clk) begin
	if (cnt == stopcnt) begin
		cnt <= 0;
		led <= ~led;
	end else begin
        cnt <= cnt + 1;
	end
    end
    assign redled = led;	// Change to redled = led;
    assign leda = led;	// Change to redled = led;
    assign ledb = led;	// Change to redled = led;
    assign ledc = led;	// Change to redled = led;
    assign ledd = led;	// Change to redled = led;
    assign lede = led;	// Change to redled = led;
    assign ledf = led;	// Change to redled = led;

/*	assign {leda, ledb,ledc,ledd,lede,ledf,redled}=gpio_out[6:0];*/
endmodule
