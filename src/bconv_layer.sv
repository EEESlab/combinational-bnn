/* Module: bconv_layer
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: Spatial 2d binary convolutional layer. Include also a 2d maxpooling 2x2 
 * operation before the output binariazion.
 */

module bconv_layer 
#(
	parameter ISIZE_W 			= 64,
	parameter ISIZE_H 			= 64,
	parameter ISIZE_FEAT 		=  1,

	parameter OSIZE_W 			= 32,
	parameter OSIZE_H 			= 32,
	parameter OSIZE_FEAT 		=  2,

	parameter CONV_KW 			=  3,
	parameter CONV_SW 			=  2,
	parameter CONV_PW 			=  1,
	parameter CONV_KH 			=  3,
	parameter CONV_SH 			=  2,
	parameter CONV_PH 			=  1,

	parameter POOL_SW 			=  2,
	parameter POOL_PW 			=  2,
	parameter POOL_SH 			=  2,
	parameter POOL_PH 			=  2,

	parameter N_RECFIELDS		= 3969,
	parameter LENGHT_RECFIELDS 	= 9,
	parameter N_BITCONV			= 4
	
)
(
	input logic [ISIZE_FEAT-1:0][ISIZE_W-1:0][ISIZE_H-1:0] layer_i, 
	input logic [OSIZE_FEAT-1:0][ISIZE_FEAT-1:0][CONV_KW*CONV_KH-1:0] weights_i, 
	input logic [OSIZE_FEAT-1:0][N_BITCONV-1:0] threshold_i, 
	input logic [OSIZE_FEAT-1:0][1:0] sign_i, 
	output logic [OSIZE_FEAT-1:0][OSIZE_W-1:0][OSIZE_H-1:0] layer_o 
);

	genvar i, j, k, ic, ik; //utils var for generative loops

	//----------------------------------------------------------------------
	//-------- Padding -----------------------------------------------------
	//----------------------------------------------------------------------	
	localparam ISIZE_W_PAD = ISIZE_W + 2*CONV_PW;
	localparam ISIZE_H_PAD = ISIZE_H + 2*CONV_PH;
    
    localparam ISIZE_W_CONV = ((ISIZE_W_PAD - CONV_KW) / CONV_SW ) +1;
	localparam ISIZE_H_CONV = ((ISIZE_H_PAD - CONV_KH) / CONV_SH ) +1;



	//----------------------------------------------------------------------
	//-------- Padding -----------------------------------------------------
	//----------------------------------------------------------------------
	logic [ISIZE_FEAT-1:0][ISIZE_W_PAD-1:0][ISIZE_H_PAD-1:0] inpLayerPadded; 
	for(k=0; k<ISIZE_FEAT; k++)
	begin
		for(i=0; i<ISIZE_W_PAD; i++)
		begin
			for(j=0; j<ISIZE_H_PAD; j++)
			begin
				if(i>=CONV_PW && i<ISIZE_W_PAD-CONV_PW && j>=CONV_PH && j<ISIZE_H_PAD-CONV_PH )
					assign inpLayerPadded[k][i][j] = layer_i[k][i-CONV_PW][j-CONV_PH];
				else
					assign inpLayerPadded[k][i][j] = 1'b0;
			end
		end
	end

	//----------------------------------------------------------------------
	//-------- Mapping the input padded layers into the receptive fields ---
	//-------- and Binary Hardware Convolution -----------------------------
	//----------------------------------------------------------------------
	logic [OSIZE_FEAT-1:0][N_RECFIELDS-1:0][LENGHT_RECFIELDS-1:0] receptField; 
	logic [OSIZE_FEAT-1:0][N_RECFIELDS-1:0][LENGHT_RECFIELDS-1:0] inpXnored; 
	logic [OSIZE_FEAT-1:0][N_RECFIELDS-1:0][N_BITCONV-1:0] outpPopCnt; 
	logic [OSIZE_FEAT-1:0][N_RECFIELDS-1:0] outpPopCntBin; 
	
	for(k=0; k<OSIZE_FEAT; k++)
	begin
		for(i=0; i<ISIZE_W_PAD-CONV_KW+1; i=i+CONV_SW)
		begin
			for(j=0; j<ISIZE_H_PAD-CONV_KH+1; j=j+CONV_SH)
			begin
				for(ic=0; ic<ISIZE_FEAT; ic++)
				begin
					for(ik=0; ik<CONV_KW; ik++)
					begin
						assign receptField[k][j+i*(ISIZE_H_PAD-CONV_KH+1)][ic*(CONV_KW*CONV_KH)+(ik+1)*CONV_KH-1:ic*(CONV_KW*CONV_KH)+ik*CONV_KH] = inpLayerPadded[ic][i+ik][j+CONV_KH-1:j];
					end
				end
				assign inpXnored[k][j+i*(ISIZE_H_PAD-CONV_KH+1)] = ~(receptField[k][j+i*(ISIZE_H_PAD-CONV_KH+1)] ^ weights_i[k]);
				popcnt_hw #(.INPUT_WIDTH(LENGHT_RECFIELDS), .OUTPUT_WIDTH(N_BITCONV)) popcnt_i (.data_in(inpXnored[k][j+i*(ISIZE_H_PAD-CONV_KH+1)]), .data_out(outpPopCnt[k][j+i*(ISIZE_H_PAD-CONV_KH+1)])) ;
				assign outpPopCntBin[k][j+i*(ISIZE_H_PAD-CONV_KH+1)] = 	((sign_i[k] == 2'b00) && (outpPopCnt[k][j+i*(ISIZE_H_PAD-CONV_KH+1)] <= threshold_i[k]))? 	1'b1 : 
																		((sign_i[k] == 2'b01) && (outpPopCnt[k][j+i*(ISIZE_H_PAD-CONV_KH+1)] >= threshold_i[k]))? 	1'b1 : 
																		 (sign_i[k] == 2'b10)? 	1'b1 : 
																		 (sign_i[k] == 2'b11)? 	1'b0 : 1'b0;
			end
		end
	end
	

	//----------------------------------------------------------------------
	//-------- Pooling and Output Binarization -----------------------------
	//----------------------------------------------------------------------
	
	for(k=0; k<OSIZE_FEAT; k++)
	begin
		for(i=0; i<OSIZE_W; i++)
		begin
			for(j=0; j<OSIZE_H; j++)
			begin
				assign layer_o[k][i][j] = 
				( outpPopCntBin[k][j*POOL_PH+0+(i*POOL_PW+0)*ISIZE_H_CONV] || 
				  outpPopCntBin[k][j*POOL_PH+1+(i*POOL_PW+0)*ISIZE_H_CONV] || 
				  outpPopCntBin[k][j*POOL_PH+0+(i*POOL_PW+1)*ISIZE_H_CONV] || 
				  outpPopCntBin[k][j*POOL_PH+1+(i*POOL_PW+1)*ISIZE_H_CONV] )? 1'b1 : 1'b0;
			end
		end
	end
	

endmodule