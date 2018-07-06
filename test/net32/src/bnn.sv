/* Module: bnn
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: BNN net32 model top-level. Configurable weights.
 */

 module bnn
(
	input logic [0:0][31:0][31:0] layer_i,

	input logic [15:0][0:0][8:0] weights_i_0,
	input logic [15:0][3:0] threshold_i_0,
	input logic [15:0][1:0] sign_i_0,
	input logic [31:0][15:0][8:0] weights_i_1,
	input logic [31:0][7:0] threshold_i_1,
	input logic [31:0][1:0] sign_i_1,
	input logic [47:0][31:0][8:0] weights_i_2,
	input logic [47:0][8:0] threshold_i_2,
	input logic [47:0][1:0] sign_i_2,
	input logic [63:0][47:0][8:0] weights_i_3,
	input logic [63:0][8:0] threshold_i_3,
	input logic [63:0][1:0] sign_i_3,
	input logic [63:0][255:0] weights_i_5,
	input logic [63:0][8:0] threshold_i_5,
	input logic [63:0][1:0] sign_i_5,
	input logic [3:0][63:0] weights_i_6,

	output logic [3:0][6:0] layer_o
);

logic [15:0][15:0][15:0] olayer_0;
logic [31:0][7:0][7:0] olayer_1;
logic [47:0][3:0][3:0] olayer_2;
logic [63:0][1:0][1:0] olayer_3;
logic [255:0] olayer_4;
logic [63:0] olayer_5;

//layer_0
bconv_layer #( .ISIZE_W (32), .ISIZE_H (32), .ISIZE_FEAT (1), .OSIZE_W (16), .OSIZE_H (16), .OSIZE_FEAT (16), .CONV_KW  (3), .CONV_SW (1), .CONV_PW (1), .CONV_KH (3), .CONV_SH (1), .CONV_PH (1), .POOL_SW (2), .POOL_PW (2), .POOL_SH (2), .POOL_PH (2), .N_RECFIELDS (1024), .LENGHT_RECFIELDS (9), .N_BITCONV (4)) binConvLayer_0 (.layer_i (layer_i), .weights_i (weights_i_0), .threshold_i (threshold_i_0), .sign_i (sign_i_0), .layer_o (olayer_0));

//layer_1
bconv_layer #( .ISIZE_W (16), .ISIZE_H (16), .ISIZE_FEAT (16), .OSIZE_W (8), .OSIZE_H (8), .OSIZE_FEAT (32), .CONV_KW  (3), .CONV_SW (1), .CONV_PW (1), .CONV_KH (3), .CONV_SH (1), .CONV_PH (1), .POOL_SW (2), .POOL_PW (2), .POOL_SH (2), .POOL_PH (2), .N_RECFIELDS (256), .LENGHT_RECFIELDS (144), .N_BITCONV (8)) binConvLayer_1 (.layer_i (olayer_0), .weights_i (weights_i_1), .threshold_i (threshold_i_1), .sign_i (sign_i_1), .layer_o (olayer_1));

//layer_2
bconv_layer #( .ISIZE_W (8), .ISIZE_H (8), .ISIZE_FEAT (32), .OSIZE_W (4), .OSIZE_H (4), .OSIZE_FEAT (48), .CONV_KW  (3), .CONV_SW (1), .CONV_PW (1), .CONV_KH (3), .CONV_SH (1), .CONV_PH (1), .POOL_SW (2), .POOL_PW (2), .POOL_SH (2), .POOL_PH (2), .N_RECFIELDS (64), .LENGHT_RECFIELDS (288), .N_BITCONV (9)) binConvLayer_2 (.layer_i (olayer_1), .weights_i (weights_i_2), .threshold_i (threshold_i_2), .sign_i (sign_i_2), .layer_o (olayer_2));

//layer_3
bconv_layer #( .ISIZE_W (4), .ISIZE_H (4), .ISIZE_FEAT (48), .OSIZE_W (2), .OSIZE_H (2), .OSIZE_FEAT (64), .CONV_KW  (3), .CONV_SW (1), .CONV_PW (1), .CONV_KH (3), .CONV_SH (1), .CONV_PH (1), .POOL_SW (2), .POOL_PW (2), .POOL_SH (2), .POOL_PH (2), .N_RECFIELDS (16), .LENGHT_RECFIELDS (432), .N_BITCONV (9)) binConvLayer_3 (.layer_i (olayer_2), .weights_i (weights_i_3), .threshold_i (threshold_i_3), .sign_i (sign_i_3), .layer_o (olayer_3));

//layer_4
bview_layer #( .ISIZE_W (2), .ISIZE_H (2), .ISIZE_FEAT (64), .OSIZE_FEAT (256)) binViewLayer_4 (.layer_i (olayer_3), .layer_o (olayer_4));

//layer_5
blin_layer #( .ISIZE_FEAT (256), .OSIZE_FEAT (64), .N_BITCONV (9)) binLinLayer_5 (.layer_i (olayer_4), .weights_i (weights_i_5), .threshold_i (threshold_i_5), .sign_i (sign_i_5), .layer_o (olayer_5));

//layer_6
blast_layer #( .ISIZE_FEAT (64), .OSIZE_FEAT (4), .N_BITCONV (7)) binLastLayer6 (.layer_i (olayer_5), .weights_i (weights_i_6), .layer_o (layer_o));

endmodule
