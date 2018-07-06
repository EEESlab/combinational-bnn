/* Module: popcnt_hw
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: HW bitcount operator (see: https://stackoverflow.com/questions/27197177/ones-count-system-verilog)
 */

module popcnt_hw 
#(
	parameter INPUT_WIDTH 	= 144,
	parameter OUTPUT_WIDTH = 8
)(
	input logic [INPUT_WIDTH-1:0] data_in,
	output logic [OUTPUT_WIDTH-1:0] data_out
);

	always_comb 
	begin
	  data_out = '0;  
	  foreach(data_in[idx]) begin
	    data_out += data_in[idx];
	  end
	end

endmodule