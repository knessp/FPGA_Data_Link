module top(clkin, datain, buttons, clkout, dataout, leds_data, leds_errors);

	input wire clkin, datain;
	input wire [3:0] buttons;
	output wire clkout;
	output wire dataout;
	output wire [3:0] leds_data;
	output wire [3:0] leds_errors;
	
	wire osc_clk;        // Internal OSCILLATOR clock
	defparam OSCH_inst.NOM_FREQ = "2.08";  
	OSCH OSCH_inst( 
		.STDBY(1'b0), // 0=Enabled, 1=Disabled
		.OSC(osc_clk),
		.SEDSTDBY()
		);
		
	assign clkout = osc_clk;
	
	wire [3:0] data_received;
	assign leds_data = data_received;
	//assign leds_errors[3] = ~clkin;
	//assign leds_errors[2] = ~datain;
	//assign leds_errors[1] = 1;
	//assign leds_errors[0] = 1;
	
	reg [3:0] errorCount; // reg so that i can do +=1 stuff
	reg [4:0] delayCount; // reg so that i can do +=1 stuff
	assign leds_errors = ~errorCount;
	

	// make instance of send module:
	send send1(.clk(osc_clk), .dataNibble(buttons), .data(dataout));
	// make instance of receive module:
	receive receive1(.clk(clkin), .data(datain), .dataNibble(data_received));
	
	always @ (posedge osc_clk) //may do buttons too
	begin
		if (data_received[3] != buttons[0])
			begin
				if (delayCount == 16)
					begin
						errorCount <= errorCount+1;
					end
				else
					delayCount <= delayCount+1;
			end
		else if (data_received[0] != buttons[3])
			begin
				if (delayCount == 16)
					begin
						errorCount <= errorCount+1;
					end
				else
					delayCount <= delayCount+1;
			end
		else if (data_received[1] != buttons[2])
			begin
				if (delayCount == 16)
					begin
						errorCount <= errorCount+1;
					end
				else
					delayCount <= delayCount+1;
			end
		else if  (data_received[2] != buttons[1])
			begin
				if (delayCount == 16)
					begin
						errorCount <= errorCount+1;
					end
				else
					delayCount <= delayCount+1;
			end
		else
			delayCount <= 0;
    end
	
	 
endmodule

module send(clk, dataNibble, data);
	input wire clk;
	input wire[3:0] dataNibble;
	output wire data;
		
	// config dataNibble into data to be sent
	
	reg [12:0] dataSymbolS;
	reg data_temp;
	reg [31:0] count; //old: 4 bits lets us count from 0 to 15 (selecting bits 0 to 8(ummmm) of dataByte)
	 
	always @ (negedge clk) //negedge clk should make a good setup time and hold time...
	begin
		dataSymbolS[8:0] <= 455; // 4b'1111 does Not work here.
		dataSymbolS[12:9] <= dataNibble;
		data_temp <= dataSymbolS[count];
		if (count == 12)
			begin
				count <= 0;
			end
		else
			count <= count+1;
    end
	//always @ (posedge clk) //this should make a good setup time and hold time...
	//begin
		//count <= count+1;
    //end
	
	assign data = data_temp;
	
endmodule

module receive(clk, data, dataNibble);
	input wire clk;
	input wire data;
	output wire [3:0] dataNibble;
	
	//at each clk posedge, store data received
	  //after enough clk edges, translate into the dataNibble
	
	reg [12:0] dataSymbolR;
	reg [3:0] dataNibble_temp;
	assign dataNibble = dataNibble_temp;
	
	//reg clk_debug;
	//reg data_debug;
	//assign clk_debug = clk;
	//assign data_debug = data;
	  
	always @ (posedge clk) //this should make a good setup time and hold time...
	begin
		dataSymbolR <= {dataSymbolR[11:0],data};
		if (dataSymbolR[12:4] == 455)
		begin
			dataNibble_temp <= dataSymbolR[3:0];
		end
    end

endmodule




