`include "top.v"
`timescale 1us/1ns

module serdesish_tb;
	
	reg clkin = 1'b0;
	reg datain = 1'b0;
	reg [0:3] buttons = 4'b0101;
	
	wire clkout; 
	wire dataout;
	wire [0:3] leds_data;
	wire [0:3] leds_errors;
	
	top DUT 
		( 
		.clkin(clkin), 
		.datain(datain), 
		.buttons(buttons), 
		.clkout(clkout), 
		.dataout(dataout), 
		.leds_data(leds_data), 
		.leds_errors(leds_errors)
		);
	
	always #2 clkin <= !clkin;
		
	initial begin
		#10
		
		datain <= 1'b1;
		#36
		
		datain <= 1'b0;
		#8
		
		datain <= 1'b1;
		#4
		
		datain <= 1'b0;
		#4
		
		datain <= 1'b1;
		#20
		
		$display("Test Complete");
	end
endmodule
