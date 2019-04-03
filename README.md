# FPGA_Data_Link

Quick Project description:
-Send and receive data using FPGA.
--Clock out and data out pins are on one side of the FPGA.
--Clock in and data in pins are on the other side of the FPGA.
--Can compare data out vs in by wiring the clock out pin to the clock in pin and the data out pin to the data in pin.
--Control what data is sent using 4 buttons. 
--See what data is received with 4 LEDs. 
--Count bit errors with the other 4 LEDs. 

Repository contains project files for the Lattice Diamond project. Created for the Lattice MachX03LF FPGA starter kit. FPGA: LCMXO3L-6900C-6BG256I

Pictures of working project:
https://photos.app.goo.gl/RVkm7j4k5ai6dnmD8 (Clock out wired to clock in with the solid colored wire. Data out wired to data in with stiped wire. Left-most button is pressed = Left-most LED turns on)
https://photos.app.goo.gl/L63SGGejSKxraPvV8 (Side view: Left-most button is pressed = Left-most LED turns on)
https://photos.app.goo.gl/qdQpCx7js85w6XPD9 (1st and 4th button is pressed = 1st and 4th LED turns on)
https://photos.app.goo.gl/b6ora8MoBVKvffPD8 (Clock and Data wires not wired correctly = 5th-8th LEDS blinking rapidly counting bit errors)

Important files:
top.v - Verilog file defining all modules.
serdesish_tb.v - Verilog file setting up test bench for top.v.
