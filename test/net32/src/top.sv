/* Module: bnn_top
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: BNN net32 model top-level. Hard-wired weights.
 */

 module bnn_top
(
	input logic [0:0][31:0][31:0] layer_i,
	output logic [3:0][6:0] layer_o
);

	logic [15:0][0:0][8:0] weights_0;
	logic [15:0][3:0] threshold_0;
	logic [15:0][1:0] sign_0;
	logic [31:0][15:0][8:0] weights_1;
	logic [31:0][7:0] threshold_1;
	logic [31:0][1:0] sign_1;
	logic [47:0][31:0][8:0] weights_2;
	logic [47:0][8:0] threshold_2;
	logic [47:0][1:0] sign_2;
	logic [63:0][47:0][8:0] weights_3;
	logic [63:0][8:0] threshold_3;
	logic [63:0][1:0] sign_3;
	logic [63:0][255:0] weights_5;
	logic [63:0][8:0] threshold_5;
	logic [63:0][1:0] sign_5;
	logic [3:0][63:0] weights_6;

	bnn bnn_i
	(
		.layer_i(layer_i),
		.weights_i_0	(weights_0),
		.threshold_i_0	(threshold_0),
		.sign_i_0		(sign_0),
		.weights_i_1	(weights_1),
		.threshold_i_1	(threshold_1),
		.sign_i_1		(sign_1),
		.weights_i_2	(weights_2),
		.threshold_i_2	(threshold_2),
		.sign_i_2		(sign_2),
		.weights_i_3	(weights_3),
		.threshold_i_3	(threshold_3),
		.sign_i_3		(sign_3),
		.weights_i_5	(weights_5),
		.threshold_i_5	(threshold_5),
		.sign_i_5		(sign_5),
		.weights_i_6	(weights_6),
		.layer_o(layer_o)
	);	

	parameters parameters_i
	(
		.weight_o_0	(weights_0),
		.threshold_o_0	(threshold_0),
		.sign_o_0		(sign_0),
		.weight_o_1	(weights_1),
		.threshold_o_1	(threshold_1),
		.sign_o_1		(sign_1),
		.weight_o_2	(weights_2),
		.threshold_o_2	(threshold_2),
		.sign_o_2		(sign_2),
		.weight_o_3	(weights_3),
		.threshold_o_3	(threshold_3),
		.sign_o_3		(sign_3),
		.weight_o_5	(weights_5),
		.threshold_o_5	(threshold_5),
		.sign_o_5		(sign_5),
		.weight_o_6	(weights_6)
	);	

endmodule
