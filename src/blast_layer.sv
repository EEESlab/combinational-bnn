/* Module: blast_layer
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: Last Fully Connected Binary Layer. No output binarization
 */


module blast_layer 
#(
	parameter ISIZE_FEAT 		= 2,
	parameter OSIZE_FEAT 		= 2,
	parameter N_BITCONV			= 2
	
)
(
	input logic [ISIZE_FEAT-1:0] layer_i, 
	input logic [OSIZE_FEAT-1:0][ISIZE_FEAT-1:0] weights_i, 
	output logic [OSIZE_FEAT-1:0][N_BITCONV-1:0] layer_o
);

	genvar k;

	//----------------------------------------------------------------------
	//-------- Mapping the input padded layers into the receptive fields ---
	//-------- and Binary Hardware Convolution -----------------------------
	//----------------------------------------------------------------------
	logic [OSIZE_FEAT-1:0][ISIZE_FEAT-1:0] inpXnored; 
	
	for(k=0; k<OSIZE_FEAT; k++)
	begin
		assign inpXnored[k] = ~(layer_i ^ weights_i[k]);
		popcnt_hw #(.INPUT_WIDTH(ISIZE_FEAT), .OUTPUT_WIDTH(N_BITCONV)) popcnt_i (.data_in(inpXnored[k]), .data_out(layer_o[k]));
	end

endmodule