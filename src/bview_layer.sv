/* Module: bview_layer
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: Reshaping tensor from 3d t0 1d representation
 */

module bview_layer 
#(
	parameter ISIZE_W 			= 	 64,
	parameter ISIZE_H 			= 	 64,
	parameter ISIZE_FEAT 		=  	  1,
	parameter OSIZE_FEAT 		=  4096
	
)
(
	input logic [ISIZE_FEAT-1:0][ISIZE_W-1:0][ISIZE_H-1:0] layer_i, 
	output logic [OSIZE_FEAT-1:0] layer_o 
);

	genvar i, k; //utils var for generative loops

	//-------- Local Parameters ------------------------------------------
	localparam SPATIAL_SIZE = ISIZE_W*ISIZE_H;

	//----------------------------------------------------------------------
	//-------- From 3D to 1D view ------------------------------------------
	//----------------------------------------------------------------------
	for(k=0; k<ISIZE_FEAT; k++)
	begin
		for(i=0; i<ISIZE_W; i++)
		begin
			assign layer_o[k*SPATIAL_SIZE+(i+1)*ISIZE_W -1 : k*SPATIAL_SIZE+i*ISIZE_W] = layer_i[ISIZE_FEAT-1-k][i];
		end
	end

endmodule