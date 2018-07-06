/* Module: tb
 * Author: Manuele Rusci - manuele.rusci@unibo.it
 * Description: BNN net32 model testbench.
 */


module tb;
	logic [99:0][31:0][31:0] layer_i;
	logic [31:0][31:0] layer;
	logic [3:0][6:0] layer_o;

	data data_i(.input_o(layer_i));
 	bnn_top bnn_top_i(.layer_i(layer), .layer_o(layer_o));

	initial
	begin
		layer = 'h0;
		#100000 layer = layer_i[0];
		#100000 layer = layer_i[1];
		#100000 layer = layer_i[2];
		#100000 layer = layer_i[3];
		#100000 layer = layer_i[4];
		#100000 layer = layer_i[5];
		#100000 layer = layer_i[6];
		#100000 layer = layer_i[7];
		#100000 layer = layer_i[8];
		#100000 layer = layer_i[9];
		#100000 layer = layer_i[10];
		#100000 layer = layer_i[11];
		#100000 layer = layer_i[12];
		#100000 layer = layer_i[13];
		#100000 layer = layer_i[14];
		#100000 layer = layer_i[15];
		#100000 layer = layer_i[16];
		#100000 layer = layer_i[17];
		#100000 layer = layer_i[18];
		#100000 layer = layer_i[19];
		#100000 layer = layer_i[20];
		#100000 layer = layer_i[21];
		#100000 layer = layer_i[22];
		#100000 layer = layer_i[23];
		#100000 layer = layer_i[24];
		#100000 layer = layer_i[25];
		#100000 layer = layer_i[26];
		#100000 layer = layer_i[27];
		#100000 layer = layer_i[28];
		#100000 layer = layer_i[29];
		#100000 layer = layer_i[30];
		#100000 layer = layer_i[31];
		#100000 layer = layer_i[32];
		#100000 layer = layer_i[33];
		#100000 layer = layer_i[34];
		#100000 layer = layer_i[35];
		#100000 layer = layer_i[36];
		#100000 layer = layer_i[37];
		#100000 layer = layer_i[38];
		#100000 layer = layer_i[39];
		#100000 layer = layer_i[40];
		#100000 layer = layer_i[41];
		#100000 layer = layer_i[42];
		#100000 layer = layer_i[43];
		#100000 layer = layer_i[44];
		#100000 layer = layer_i[45];
		#100000 layer = layer_i[46];
		#100000 layer = layer_i[47];
		#100000 layer = layer_i[48];
		#100000 layer = layer_i[49];
		#100000 layer = layer_i[50];
		#100000 layer = layer_i[51];
		#100000 layer = layer_i[52];
		#100000 layer = layer_i[53];
		#100000 layer = layer_i[54];
		#100000 layer = layer_i[55];
		#100000 layer = layer_i[56];
		#100000 layer = layer_i[57];
		#100000 layer = layer_i[58];
		#100000 layer = layer_i[59];
		#100000 layer = layer_i[60];
		#100000 layer = layer_i[61];
		#100000 layer = layer_i[62];
		#100000 layer = layer_i[63];
		#100000 layer = layer_i[64];
		#100000 layer = layer_i[65];
		#100000 layer = layer_i[66];
		#100000 layer = layer_i[67];
		#100000 layer = layer_i[68];
		#100000 layer = layer_i[69];
		#100000 layer = layer_i[70];
		#100000 layer = layer_i[71];
		#100000 layer = layer_i[72];
		#100000 layer = layer_i[73];
		#100000 layer = layer_i[74];
		#100000 layer = layer_i[75];
		#100000 layer = layer_i[76];
		#100000 layer = layer_i[77];
		#100000 layer = layer_i[78];
		#100000 layer = layer_i[79];
		#100000 layer = layer_i[80];
		#100000 layer = layer_i[81];
		#100000 layer = layer_i[82];
		#100000 layer = layer_i[83];
		#100000 layer = layer_i[84];
		#100000 layer = layer_i[85];
		#100000 layer = layer_i[86];
		#100000 layer = layer_i[87];
		#100000 layer = layer_i[88];
		#100000 layer = layer_i[89];
		#100000 layer = layer_i[90];
		#100000 layer = layer_i[91];
		#100000 layer = layer_i[92];
		#100000 layer = layer_i[93];
		#100000 layer = layer_i[94];
		#100000 layer = layer_i[95];
		#100000 layer = layer_i[96];
		#100000 layer = layer_i[97];
		#100000 layer = layer_i[98];
		#100000 layer = layer_i[99];
		#1000 $finish;
	end
endmodule
