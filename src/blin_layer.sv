/* Module: blin_layer
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: Fully Connected Binary Layer
 */


module blin_layer 
#(
	parameter ISIZE_FEAT 		= 2,
	parameter OSIZE_FEAT 		= 2,
	parameter N_BITCONV			= 2
	
)
(
	input logic [ISIZE_FEAT-1:0] layer_i, 
	input logic [OSIZE_FEAT-1:0][ISIZE_FEAT-1:0] weights_i, 
	input logic [OSIZE_FEAT-1:0][N_BITCONV-1:0] threshold_i, 
	input logic [OSIZE_FEAT-1:0][1:0] sign_i, 
	output logic [OSIZE_FEAT-1:0] layer_o 
);

	genvar k;

	//----------------------------------------------------------------------
	//-------- Mapping the input padded layers into the receptive fields ---
	//-------- and Binary Hardware Convolution -----------------------------
	//----------------------------------------------------------------------
	logic [OSIZE_FEAT-1:0][ISIZE_FEAT-1:0] inpXnored; 
	logic [OSIZE_FEAT-1:0][N_BITCONV-1:0] outpPopCnt; 
	
	for(k=0; k<OSIZE_FEAT; k++)
	begin
		assign inpXnored[k] = ~(layer_i ^ weights_i[k]);
		popcnt_hw #(.INPUT_WIDTH(ISIZE_FEAT), .OUTPUT_WIDTH(N_BITCONV)) popcnt_i (.data_in(inpXnored[k]), .data_out(outpPopCnt[k]));
		assign layer_o[OSIZE_FEAT-1-k] = ((sign_i[k] == 2'b00) && (outpPopCnt[k] <= threshold_i[k]))? 	1'b1 : 
							((sign_i[k] == 2'b01) && (outpPopCnt[k] >= threshold_i[k]))? 	1'b1 : 
							 (sign_i[k] == 2'b10)? 											1'b1 : 
							 (sign_i[k] == 2'b11)? 											1'b0 :	
							 																1'b0 ;
	end

endmodule