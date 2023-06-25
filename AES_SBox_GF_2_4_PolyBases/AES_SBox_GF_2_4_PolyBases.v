/*****************************************************
*       _________        __________               
*      /   _____/        \______   \ _______  ___ 
*      \_____  \   ______ |    |  _//  _ \  \/  / 
*      /        \ /_____/ |    |   (  <_> >    <  
*     /_______  /         |______  /\____/__/\_ \ 
*             \/                 \/            \/ 
*
*****************************************************/

/*****************************************************
* Last Modified: Utsav Banerjee (25th June 2023)
*****************************************************/



/*****************************************************
*
* Auto-Generated using gen_GF_2_4_SBox_RTL_PolyBases
*
* in -> map -> inverse -> inv_map + affine -> out
*
*****************************************************/

/*****************************************************
* Affine Matrix:
*
*	1 1 1 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 
*	0 0 1 1 1 1 1 0 
*	0 0 0 1 1 1 1 1 
*	1 0 0 0 1 1 1 1 
*	1 1 0 0 0 1 1 1 
*	1 1 1 0 0 0 1 1 
*	1 1 1 1 0 0 0 1 
*****************************************************/



/*****************************************************
* S-Box # 1 - 1 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 1 0 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 1 0 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 0 1 0 0 1 0 0 
*	1 1 0 0 0 1 0 0 	0 0 1 1 1 1 0 0 
*	1 0 1 1 1 1 0 0 	1 0 0 1 1 1 0 0 
*	1 0 0 0 1 1 1 0 	0 1 1 1 0 0 0 0 
*	0 0 1 0 1 1 0 1 	1 1 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[2];
	assign inL[2] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 1 0 0 1 1 0 
	*	0 0 0 0 0 1 1 1 
	*	1 1 1 1 0 0 0 1 
	*	1 0 0 0 1 0 1 1 
	*	0 1 0 0 0 1 0 1 
	*	0 0 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 1 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 0 1 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 1 1 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 1 1 0 0 1 0 0 
*	0 1 1 0 0 1 0 0 	1 1 1 1 1 1 0 0 
*	1 1 0 0 1 1 1 0 	0 1 0 1 1 1 0 0 
*	0 0 1 0 0 0 1 0 	0 1 1 1 0 0 0 0 
*	1 1 1 1 0 0 0 1 	1 1 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[5] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[5] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 0 0 0 1 1 0 
	*	0 1 1 1 0 1 1 1 
	*	1 1 1 0 0 0 0 1 
	*	0 0 1 1 1 0 1 1 
	*	0 0 0 1 0 1 0 1 
	*	0 0 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 1 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 0 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 0 0 1 0 1 0 
*	0 0 0 1 1 0 0 0 	1 1 0 0 0 0 1 0 
*	1 1 1 1 1 1 0 0 	0 0 0 0 0 0 1 0 
*	0 0 0 0 0 1 0 0 	1 0 1 1 0 0 0 0 
*	1 0 1 0 0 0 0 1 	1 0 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 1 0 1 1 1 0 
	*	0 0 1 1 1 0 1 1 
	*	0 0 1 0 0 1 0 1 
	*	0 1 1 0 1 0 0 1 
	*	0 0 1 1 1 1 1 1 
	*	0 1 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 1 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 1 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 1 0 1 0 1 0 
*	1 0 1 1 1 0 0 0 	1 1 1 0 0 0 1 0 
*	0 1 0 1 0 0 0 0 	0 0 1 0 0 0 1 0 
*	1 1 0 1 0 1 1 0 	1 0 1 1 0 0 0 0 
*	1 1 0 1 0 0 0 1 	1 0 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[6] ^ in[4];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 0 0 1 1 1 0 
	*	1 0 0 0 1 0 1 1 
	*	0 1 1 1 0 1 0 1 
	*	1 1 1 1 1 0 0 1 
	*	1 1 0 0 1 1 1 1 
	*	0 0 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 1 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 0 0 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 1 0 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 0 0 1 1 1 0 0 
*	1 1 0 0 1 0 0 0 	1 1 0 0 0 1 0 0 
*	0 1 1 1 1 0 1 0 	1 1 1 0 0 1 0 0 
*	0 0 1 1 1 0 0 0 	1 0 0 1 0 0 0 0 
*	0 0 0 0 1 0 0 1 	1 1 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[5] ^ in[4] ^ in[3];
	assign inL[0] = in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 1 1 0 1 1 0 
	*	0 1 1 0 1 0 0 1 
	*	0 0 1 0 1 1 1 1 
	*	0 1 1 1 1 1 0 1 
	*	0 1 0 0 0 0 1 1 
	*	1 1 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 1 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 1 1 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 1 1 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 1 0 1 1 1 0 0 
*	0 1 1 0 1 0 0 0 	1 0 0 0 0 1 0 0 
*	1 0 1 0 1 0 0 0 	1 0 1 0 0 1 0 0 
*	0 0 1 1 0 1 0 0 	1 0 0 1 0 0 0 0 
*	1 0 1 0 1 0 1 1 	1 0 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3];
	assign inL[2] = in[7] ^ in[5] ^ in[3];
	assign inL[1] = in[5] ^ in[4] ^ in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 0 1 0 1 1 0 
	*	1 1 1 1 1 0 0 1 
	*	1 1 0 1 1 1 1 1 
	*	1 0 1 0 1 1 0 1 
	*	0 1 1 1 0 0 1 1 
	*	0 0 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 1 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 0 0 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 1 0 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 0 1 0 0 0 1 0 
*	1 1 0 0 1 0 1 0 	0 0 0 0 1 0 1 0 
*	1 1 1 0 0 1 1 0 	0 1 0 0 1 0 1 0 
*	1 1 0 0 0 0 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 0 0 0 1 1 	0 1 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 1 1 1 1 1 0 
	*	0 1 1 1 1 1 0 1 
	*	0 0 0 1 0 0 1 1 
	*	0 0 0 0 0 1 1 1 
	*	0 0 0 0 0 0 0 1 
	*	0 1 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 1 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 1 1 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 0 0 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 0 0 0 0 0 1 0 
*	0 1 1 0 1 0 1 0 	1 0 1 0 1 0 1 0 
*	1 1 1 0 1 0 1 0 	1 1 1 0 1 0 1 0 
*	1 0 1 1 0 0 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 0 1 1 0 1 	1 0 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_1_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[4];
	assign inL[0] = in[6] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 0 1 1 1 1 0 
	*	1 0 1 0 1 1 0 1 
	*	0 0 1 0 0 0 1 1 
	*	0 1 1 1 0 1 1 1 
	*	0 0 0 1 0 0 0 1 
	*	0 1 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 0 1 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 0 0 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 0 0 1 0 1 0 0 
*	0 0 0 1 1 0 1 0 	1 1 1 0 1 1 0 0 
*	0 1 1 0 1 1 0 0 	0 1 0 0 1 1 0 0 
*	0 0 1 0 0 0 0 0 	0 1 1 1 0 0 0 0 
*	1 1 1 1 1 1 1 1 	0 1 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[1] = in[5];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 0 0 0 1 1 0 
	*	0 0 1 0 0 1 1 1 
	*	0 0 1 1 0 0 0 1 
	*	0 1 1 1 1 0 1 1 
	*	0 0 1 1 0 1 0 1 
	*	1 1 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 1 0 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 0 1 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 1 0 1 0 1 0 0 
*	1 0 1 1 1 0 1 0 	0 0 1 0 1 1 0 0 
*	0 0 0 1 1 1 1 0 	1 0 0 0 1 1 0 0 
*	1 0 0 0 1 1 0 0 	0 1 1 1 0 0 0 0 
*	0 0 1 0 0 0 1 1 	0 1 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[3] ^ in[2];
	assign inL[0] = in[5] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 1 0 0 1 1 0 
	*	0 1 0 1 0 1 1 1 
	*	0 0 1 0 0 0 0 1 
	*	1 1 0 0 1 0 1 1 
	*	0 1 1 0 0 1 0 1 
	*	1 1 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 0 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 1 1 1 0 1 0 
*	0 1 1 0 0 1 1 0 	1 0 0 1 0 0 1 0 
*	1 1 1 1 1 1 1 0 	0 1 0 1 0 0 1 0 
*	1 1 0 1 1 0 0 0 	1 0 1 1 0 0 0 0 
*	1 0 1 0 1 1 0 1 	0 1 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 1 0 1 1 1 0 
	*	1 1 0 0 1 0 1 1 
	*	0 1 0 1 0 1 0 1 
	*	1 1 0 0 1 0 0 1 
	*	0 1 1 1 1 1 1 1 
	*	0 0 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 1 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 0 1 1 0 1 0 
*	1 1 0 0 0 1 1 0 	1 0 1 1 0 0 1 0 
*	0 1 0 1 0 0 1 0 	0 1 1 1 0 0 1 0 
*	0 0 0 0 1 0 1 0 	1 0 1 1 0 0 0 0 
*	1 1 0 1 1 1 0 1 	0 1 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[4] ^ in[1];
	assign inL[1] = in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 0 0 1 1 1 0 
	*	0 1 1 1 1 0 1 1 
	*	0 0 0 0 0 1 0 1 
	*	0 1 0 1 1 0 0 1 
	*	1 0 0 0 1 1 1 1 
	*	0 1 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 0 0 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 1 0 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 0 0 0 1 1 0 0 
*	1 0 1 1 0 1 1 0 	0 0 1 1 0 1 0 0 
*	1 0 1 0 0 1 1 0 	0 0 0 1 0 1 0 0 
*	0 1 0 0 0 1 0 0 	1 0 0 1 0 0 0 0 
*	1 1 0 1 1 0 0 1 	1 1 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 1 1 0 1 1 0 
	*	0 1 0 1 1 0 0 1 
	*	1 0 0 1 1 1 1 1 
	*	1 0 1 1 1 1 0 1 
	*	1 1 1 0 0 0 1 1 
	*	0 1 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 1 1 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 1 1 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 1 0 0 1 1 0 0 
*	0 0 0 1 0 1 1 0 	0 1 1 1 0 1 0 0 
*	0 1 1 1 0 1 0 0 	0 1 0 1 0 1 0 0 
*	0 1 0 0 1 0 0 0 	1 0 0 1 0 0 0 0 
*	0 1 1 1 1 0 1 1 	1 0 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[1] = in[6] ^ in[3];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 0 1 0 1 1 0 
	*	1 1 0 0 1 0 0 1 
	*	0 1 1 0 1 1 1 1 
	*	0 1 1 0 1 1 0 1 
	*	1 1 0 1 0 0 1 1 
	*	1 0 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 0 0 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 0 0 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 1 1 1 0 0 1 0 
*	1 0 1 1 0 1 0 0 	0 0 1 1 1 0 1 0 
*	1 0 0 1 1 0 1 0 	0 1 1 1 1 0 1 0 
*	0 1 1 0 0 0 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 0 1 1 1 1 	0 0 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[5];
	assign inL[0] = in[6] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 1 1 1 1 1 0 
	*	0 1 1 0 1 1 0 1 
	*	1 0 0 0 0 0 1 1 
	*	0 0 1 0 0 1 1 1 
	*	1 1 0 0 0 0 0 1 
	*	1 1 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 2 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 1 1 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 1 0 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 1 0 1 0 0 1 0 
*	0 0 0 1 0 1 0 0 	1 0 0 1 1 0 1 0 
*	1 0 0 1 0 1 1 0 	1 1 0 1 1 0 1 0 
*	0 0 0 1 0 0 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 0 0 0 0 1 	1 1 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_2_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 0 1 1 1 1 0 
	*	1 0 1 1 1 1 0 1 
	*	1 0 1 1 0 0 1 1 
	*	0 1 0 1 0 1 1 1 
	*	1 1 0 1 0 0 0 1 
	*	1 1 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 0 1 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 0 0 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 0 0 0 0 1 0 0 
*	0 1 1 0 1 0 1 0 	1 1 0 0 1 1 0 0 
*	1 0 1 1 0 0 0 0 	0 1 1 0 1 1 0 0 
*	1 0 0 0 0 0 0 0 	0 1 1 1 0 0 0 0 
*	1 1 1 1 1 1 0 1 	1 0 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[4];
	assign inL[1] = in[7];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 0 1 0 1 1 0 
	*	1 1 0 0 0 1 1 1 
	*	0 1 0 0 0 0 0 1 
	*	1 0 1 1 1 0 1 1 
	*	0 1 0 1 0 1 0 1 
	*	1 0 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 1 0 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 0 1 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 1 0 0 0 1 0 0 
*	1 1 0 0 1 0 1 0 	0 0 0 0 1 1 0 0 
*	1 1 0 0 0 0 1 0 	1 0 1 0 1 1 0 0 
*	0 0 1 0 1 1 0 0 	0 1 1 1 0 0 0 0 
*	0 0 1 0 0 0 0 1 	1 0 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[1];
	assign inL[1] = in[5] ^ in[3] ^ in[2];
	assign inL[0] = in[5] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 1 1 0 1 1 0 
	*	1 0 1 1 0 1 1 1 
	*	0 1 0 1 0 0 0 1 
	*	0 0 0 0 1 0 1 1 
	*	0 0 0 0 0 1 0 1 
	*	1 0 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[0];
	assign out[2] = outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 0 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 1 0 1 0 1 0 
*	0 1 1 0 0 1 0 0 	0 0 1 1 0 0 1 0 
*	0 0 1 0 0 0 1 0 	1 1 1 1 0 0 1 0 
*	1 0 1 0 1 0 1 0 	1 0 1 1 0 0 0 0 
*	1 1 0 1 0 0 1 1 	0 0 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[2];
	assign inL[2] = in[5] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 1 0 1 1 1 0 
	*	1 0 1 1 1 0 1 1 
	*	0 1 1 0 0 1 0 1 
	*	0 0 0 1 1 0 0 1 
	*	0 1 0 1 1 1 1 1 
	*	0 0 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 1 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 0 0 1 0 1 0 
*	1 1 0 0 0 1 0 0 	0 0 0 1 0 0 1 0 
*	1 0 0 0 1 1 1 0 	1 1 0 1 0 0 1 0 
*	0 1 1 1 1 0 0 0 	1 0 1 1 0 0 0 0 
*	1 0 1 0 0 0 1 1 	0 0 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[2];
	assign inL[2] = in[7] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[5] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 0 0 1 1 1 0 
	*	0 0 0 0 1 0 1 1 
	*	0 0 1 1 0 1 0 1 
	*	1 0 0 0 1 0 0 1 
	*	1 0 1 0 1 1 1 1 
	*	0 1 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 1 1 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 1 0 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 1 1 0 1 1 0 0 
*	1 0 1 1 1 0 0 0 	0 1 1 0 0 1 0 0 
*	1 1 0 1 0 1 1 0 	0 1 0 0 0 1 0 0 
*	1 1 1 0 1 0 0 0 	1 0 0 1 0 0 0 0 
*	0 0 0 0 0 1 1 1 	1 1 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3];
	assign inL[0] = in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 0 0 0 1 1 0 
	*	1 0 0 0 1 0 0 1 
	*	1 0 1 1 1 1 1 1 
	*	0 0 1 1 1 1 0 1 
	*	0 0 1 0 0 0 1 1 
	*	0 1 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 0 0 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 1 1 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 0 1 0 1 1 0 0 
*	0 0 0 1 1 0 0 0 	0 0 1 0 0 1 0 0 
*	0 0 0 0 0 1 0 0 	0 0 0 0 0 1 0 0 
*	1 1 1 0 0 1 0 0 	1 0 0 1 0 0 0 0 
*	1 0 1 0 0 1 0 1 	1 0 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[4] ^ in[3];
	assign inL[2] = in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 1 0 0 1 1 0 
	*	0 0 0 1 1 0 0 1 
	*	0 1 0 0 1 1 1 1 
	*	1 1 1 0 1 1 0 1 
	*	0 0 0 1 0 0 1 1 
	*	1 0 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 1 0 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 1 1 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 1 0 1 0 0 1 0 
*	1 1 0 0 1 0 0 0 	0 0 1 0 1 0 1 0 
*	0 0 1 1 1 0 0 0 	0 1 1 0 1 0 1 0 
*	1 0 1 1 0 0 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 1 0 0 0 1 	0 0 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3];
	assign inL[2] = in[5] ^ in[4] ^ in[3];
	assign inL[1] = in[7] ^ in[5] ^ in[4] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 1 1 1 1 1 0 
	*	1 1 1 0 1 1 0 1 
	*	0 1 0 0 0 0 1 1 
	*	1 0 1 1 0 1 1 1 
	*	1 0 1 0 0 0 0 1 
	*	0 0 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 3 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + A
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 0 1 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 0 1 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 1 1 1 0 0 1 0 
*	0 1 1 0 1 0 0 0 	1 0 0 0 1 0 1 0 
*	0 0 1 1 0 1 0 0 	1 1 0 0 1 0 1 0 
*	1 1 0 0 0 0 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 1 1 1 1 1 	1 1 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_3_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3];
	assign inL[2] = in[5] ^ in[4] ^ in[2];
	assign inL[1] = in[7] ^ in[6];
	assign inL[0] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hA));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 0 1 1 1 1 0 
	*	0 0 1 1 1 1 0 1 
	*	0 1 1 1 0 0 1 1 
	*	1 1 0 0 0 1 1 1 
	*	1 0 1 1 0 0 0 1 
	*	0 0 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 1 0 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 1 0 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 0 1 1 0 1 0 0 
*	1 0 1 1 0 1 0 0 	0 0 0 1 1 1 0 0 
*	0 1 1 0 0 0 0 0 	1 0 1 1 1 1 0 0 
*	0 0 1 0 1 1 1 0 	0 1 1 1 0 0 0 0 
*	0 0 1 0 1 1 1 1 	0 0 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[6] ^ in[5];
	assign inL[1] = in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 1 1 0 1 1 0 
	*	1 1 1 0 0 1 1 1 
	*	1 0 0 0 0 0 0 1 
	*	0 1 0 0 1 0 1 1 
	*	0 0 1 0 0 1 0 1 
	*	0 1 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 0 1 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 1 1 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 1 1 1 0 1 0 0 
*	0 0 0 1 0 1 0 0 	1 1 0 1 1 1 0 0 
*	0 0 0 1 0 0 1 0 	0 1 1 1 1 1 0 0 
*	1 0 0 0 0 0 1 0 	0 1 1 1 0 0 0 0 
*	1 1 1 1 0 0 1 1 	0 0 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[4] ^ in[2];
	assign inL[2] = in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 0 1 0 1 1 0 
	*	1 0 0 1 0 1 1 1 
	*	1 0 0 1 0 0 0 1 
	*	1 1 1 1 1 0 1 1 
	*	0 1 1 1 0 1 0 1 
	*	0 1 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 0 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 0 1 1 0 1 0 
*	0 0 0 1 1 0 1 0 	0 1 1 0 0 0 1 0 
*	0 0 1 0 0 0 0 0 	1 0 1 0 0 0 1 0 
*	0 1 1 1 0 1 1 0 	1 0 1 1 0 0 0 0 
*	1 1 0 1 1 1 1 1 	1 1 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[5];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 1 0 1 1 1 0 
	*	0 1 0 0 1 0 1 1 
	*	0 0 0 1 0 1 0 1 
	*	1 0 1 1 1 0 0 1 
	*	0 0 0 1 1 1 1 1 
	*	0 1 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 1 0 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 1 1 1 0 1 0 
*	1 0 1 1 1 0 1 0 	0 1 0 0 0 0 1 0 
*	1 0 0 0 1 1 0 0 	1 0 0 0 0 0 1 0 
*	1 0 1 0 0 1 0 0 	1 0 1 1 0 0 0 0 
*	1 0 1 0 1 1 1 1 	1 1 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[5] ^ in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 0 0 1 1 1 0 
	*	1 1 1 1 1 0 1 1 
	*	0 1 0 0 0 1 0 1 
	*	0 0 1 0 1 0 0 1 
	*	1 1 1 0 1 1 1 1 
	*	0 0 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outL[2] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 1 1 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 1 0 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 1 1 1 1 1 0 0 
*	1 1 0 0 0 1 1 0 	1 0 0 1 0 1 0 0 
*	0 0 0 0 1 0 1 0 	1 0 1 1 0 1 0 0 
*	1 0 0 1 0 1 0 0 	1 0 0 1 0 0 0 0 
*	1 1 0 1 0 1 1 1 	1 1 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[2] ^ in[1];
	assign inL[2] = in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[4] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 0 0 0 1 1 0 
	*	1 0 1 1 1 0 0 1 
	*	0 0 0 0 1 1 1 1 
	*	1 1 1 1 1 1 0 1 
	*	1 0 0 0 0 0 1 1 
	*	1 1 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 0 0 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 1 1 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 0 1 1 1 1 0 0 
*	0 1 1 0 0 1 1 0 	1 1 0 1 0 1 0 0 
*	1 1 0 1 1 0 0 0 	1 1 1 1 0 1 0 0 
*	1 0 0 1 1 0 0 0 	1 0 0 1 0 0 0 0 
*	0 1 1 1 0 1 0 1 	1 0 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[3];
	assign inL[1] = in[7] ^ in[4] ^ in[3];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 1 0 0 1 1 0 
	*	0 0 1 0 1 0 0 1 
	*	1 1 1 1 1 1 1 1 
	*	0 0 1 0 1 1 0 1 
	*	1 0 1 1 0 0 1 1 
	*	0 0 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 1 0 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 0 1 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 0 0 0 0 0 1 0 
*	1 0 1 1 0 1 1 0 	0 0 0 1 1 0 1 0 
*	0 1 0 0 0 1 0 0 	0 1 0 1 1 0 1 0 
*	0 0 0 1 0 0 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 1 1 1 0 1 	0 1 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[2];
	assign inL[1] = in[4];
	assign inL[0] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 1 1 1 1 1 0 
	*	1 1 1 1 1 1 0 1 
	*	1 1 0 1 0 0 1 1 
	*	1 0 0 1 0 1 1 1 
	*	0 1 1 0 0 0 0 1 
	*	1 0 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 4 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + B
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 0 1 1 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 1 1 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 0 1 0 0 0 1 0 
*	0 0 0 1 0 1 1 0 	1 0 1 1 1 0 1 0 
*	0 1 0 0 1 0 0 0 	1 1 1 1 1 0 1 0 
*	0 1 1 0 0 0 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 1 0 0 1 1 	1 0 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_4_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[3];
	assign inL[1] = in[6] ^ in[5] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hB));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 0 1 1 1 1 0 
	*	0 0 1 0 1 1 0 1 
	*	1 1 1 0 0 0 1 1 
	*	1 1 1 0 0 1 1 1 
	*	0 1 1 1 0 0 0 1 
	*	1 0 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 0 0 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 0 0 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 0 1 0 0 1 0 0 
*	0 0 0 1 1 0 0 0 	1 0 1 0 1 1 0 0 
*	0 0 0 1 1 1 0 0 	0 0 0 0 1 1 0 0 
*	1 1 1 1 1 1 0 0 	0 1 1 1 0 0 0 0 
*	0 1 0 1 1 1 0 1 	1 0 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[4] ^ in[3];
	assign inL[2] = in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 1 0 0 1 1 0 
	*	1 1 1 1 0 1 1 1 
	*	1 1 0 0 0 0 0 1 
	*	1 1 1 0 1 0 1 1 
	*	1 1 1 1 0 1 0 1 
	*	0 0 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 1 1 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 0 1 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 1 1 0 0 1 0 0 
*	1 0 1 1 1 0 0 0 	0 1 1 0 1 1 0 0 
*	0 1 1 0 1 1 1 0 	1 1 0 0 1 1 0 0 
*	0 1 0 1 0 0 0 0 	0 1 1 1 0 0 0 0 
*	1 0 0 0 0 0 0 1 	1 0 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[4];
	assign inL[0] = in[7] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 0 0 0 1 1 0 
	*	1 0 0 0 0 1 1 1 
	*	1 1 0 1 0 0 0 1 
	*	0 1 0 1 1 0 1 1 
	*	1 0 1 0 0 1 0 1 
	*	0 0 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 0 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 0 1 1 0 1 0 
*	0 1 1 0 1 0 0 0 	1 0 0 0 0 0 1 0 
*	0 1 0 1 1 1 0 0 	0 1 0 0 0 0 1 0 
*	1 0 1 0 1 0 0 0 	1 0 1 1 0 0 0 0 
*	0 0 0 0 0 0 1 1 	1 0 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[3];
	assign inL[2] = in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[5] ^ in[3];
	assign inL[0] = in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 1 1 1 1 1 0 
	*	0 1 0 1 1 0 1 1 
	*	1 0 0 1 0 1 0 1 
	*	0 1 0 0 1 0 0 1 
	*	1 1 0 1 1 1 1 1 
	*	1 1 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 1 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 1 1 1 0 1 0 
*	1 1 0 0 1 0 0 0 	1 0 1 0 0 0 1 0 
*	1 1 1 1 0 0 0 0 	0 1 1 0 0 0 1 0 
*	0 1 1 1 1 0 1 0 	1 0 1 1 0 0 0 0 
*	0 1 1 1 0 0 1 1 	1 0 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 0 1 1 1 1 0 
	*	1 1 1 0 1 0 1 1 
	*	1 1 0 0 0 1 0 1 
	*	1 1 0 1 1 0 0 1 
	*	0 0 1 0 1 1 1 1 
	*	1 0 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 1 0 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 0 0 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 0 0 0 1 1 0 0 
*	0 1 1 0 1 0 1 0 	0 1 0 0 0 1 0 0 
*	1 1 0 1 1 0 1 0 	0 1 1 0 0 1 0 0 
*	1 1 1 0 1 0 1 0 	1 0 0 1 0 0 0 0 
*	1 0 1 0 0 1 1 1 	0 1 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 1 1 0 1 1 0 
	*	0 1 0 0 1 0 0 1 
	*	1 1 0 0 1 1 1 1 
	*	1 1 0 1 1 1 0 1 
	*	0 0 1 1 0 0 1 1 
	*	0 0 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 0 1 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 0 1 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 1 0 0 1 1 0 0 
*	1 1 0 0 1 0 1 0 	0 0 0 0 0 1 0 0 
*	0 0 0 0 1 0 0 0 	0 0 1 0 0 1 0 0 
*	1 1 1 0 0 1 1 0 	1 0 0 1 0 0 0 0 
*	0 0 0 0 0 1 0 1 	0 0 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[1];
	assign inL[2] = in[3];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[0] = in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 0 1 0 1 1 0 
	*	1 1 0 1 1 0 0 1 
	*	0 0 1 1 1 1 1 1 
	*	0 0 0 0 1 1 0 1 
	*	0 0 0 0 0 0 1 1 
	*	1 1 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 1 0 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 1 0 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 1 1 0 0 0 1 0 
*	0 1 1 0 0 1 0 0 	0 1 0 1 1 0 1 0 
*	0 1 0 0 0 1 1 0 	0 0 0 1 1 0 1 0 
*	1 1 0 0 1 1 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 1 1 1 1 1 	1 0 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[2];
	assign inL[2] = in[6] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 1 0 1 1 1 0 
	*	1 1 0 1 1 1 0 1 
	*	0 1 1 0 0 0 1 1 
	*	1 1 1 1 0 1 1 1 
	*	0 0 1 1 0 0 0 1 
	*	0 0 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 5 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + C
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 0 1 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 0 0 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 1 0 0 0 0 1 0 
*	1 1 0 0 0 1 0 0 	1 1 1 1 1 0 1 0 
*	0 1 0 0 1 0 1 0 	1 0 1 1 1 0 1 0 
*	1 0 1 1 1 1 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 1 0 0 0 1 	0 1 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_5_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[2];
	assign inL[2] = in[6] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hC));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 0 0 1 1 1 0 
	*	0 0 0 0 1 1 0 1 
	*	0 1 0 1 0 0 1 1 
	*	1 0 0 0 0 1 1 1 
	*	0 0 1 0 0 0 0 1 
	*	0 0 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 0 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 1 1 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 1 0 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 0 0 1 0 1 0 0 
*	1 1 0 0 0 1 1 0 	0 1 1 1 1 1 0 0 
*	1 1 0 0 1 1 0 0 	1 1 0 1 1 1 0 0 
*	0 1 0 1 0 0 1 0 	0 1 1 1 0 0 0 0 
*	1 0 0 0 1 1 1 1 	0 0 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[3] ^ in[2];
	assign inL[1] = in[6] ^ in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 0 0 0 1 1 0 
	*	1 1 0 1 0 1 1 1 
	*	0 0 0 0 0 0 0 1 
	*	0 0 0 1 1 0 1 1 
	*	1 0 0 0 0 1 0 1 
	*	1 1 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 0 0 0 0 1 1 0 
*	1 0 1 0 1 1 0 0 	0 1 1 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 1 0 1 0 1 0 0 
*	0 1 1 0 0 1 1 0 	1 0 1 1 1 1 0 0 
*	1 0 1 1 1 1 1 0 	0 0 0 1 1 1 0 0 
*	1 1 1 1 1 1 1 0 	0 1 1 1 0 0 0 0 
*	0 1 0 1 0 0 1 1 	0 0 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 1 0 0 1 1 0 
	*	1 0 1 0 0 1 1 1 
	*	0 0 0 1 0 0 0 1 
	*	1 0 1 0 1 0 1 1 
	*	1 1 0 1 0 1 0 1 
	*	1 1 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 0 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 1 0 1 0 1 0 
*	0 0 0 1 0 1 1 0 	1 1 0 1 0 0 1 0 
*	0 1 0 1 1 1 1 0 	0 0 0 1 0 0 1 0 
*	0 1 1 1 0 1 0 0 	1 0 1 1 0 0 0 0 
*	0 0 0 0 1 1 1 1 	0 1 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[0] = in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 1 1 1 1 1 0 
	*	1 0 1 0 1 0 1 1 
	*	1 1 1 0 0 1 0 1 
	*	1 1 1 0 1 0 0 1 
	*	1 0 0 1 1 1 1 1 
	*	1 0 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 1 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 0 0 1 0 1 0 
*	1 0 1 1 0 1 1 0 	1 1 1 1 0 0 1 0 
*	1 1 1 1 0 0 1 0 	0 0 1 1 0 0 1 0 
*	1 0 1 0 0 1 1 0 	1 0 1 1 0 0 0 0 
*	0 1 1 1 1 1 1 1 	0 1 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 0 1 1 1 1 0 
	*	0 0 0 1 1 0 1 1 
	*	1 0 1 1 0 1 0 1 
	*	0 1 1 1 1 0 0 1 
	*	0 1 1 0 1 1 1 1 
	*	1 1 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 1 0 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 0 0 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 0 0 1 1 1 0 0 
*	0 0 0 1 0 1 0 0 	1 0 1 1 0 1 0 0 
*	0 0 0 0 0 1 1 0 	1 0 0 1 0 1 0 0 
*	1 0 0 1 0 1 1 0 	1 0 0 1 0 0 0 0 
*	0 1 1 1 0 1 1 1 	0 1 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[4] ^ in[2];
	assign inL[2] = in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 1 1 0 1 1 0 
	*	0 1 1 1 1 0 0 1 
	*	0 1 1 1 1 1 1 1 
	*	0 0 0 1 1 1 0 1 
	*	1 0 0 1 0 0 1 1 
	*	1 0 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 0 1 1 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 0 1 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 1 0 1 1 1 0 0 
*	1 0 1 1 0 1 0 0 	1 1 1 1 0 1 0 0 
*	1 1 0 1 0 1 0 0 	1 1 0 1 0 1 0 0 
*	1 0 0 1 1 0 1 0 	1 0 0 1 0 0 0 0 
*	1 1 0 1 0 1 0 1 	0 0 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[2];
	assign inL[1] = in[7] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 0 1 0 1 1 0 
	*	1 1 1 0 1 0 0 1 
	*	1 0 0 0 1 1 1 1 
	*	1 1 0 0 1 1 0 1 
	*	1 0 1 0 0 0 1 1 
	*	0 1 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 1 0 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 0 0 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 0 1 1 0 0 1 0 
*	0 0 0 1 1 0 1 0 	0 1 1 0 1 0 1 0 
*	0 0 1 1 1 0 1 0 	0 0 1 0 1 0 1 0 
*	0 1 1 0 1 1 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 1 0 0 1 1 	1 1 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 1 0 1 1 1 0 
	*	1 1 0 0 1 1 0 1 
	*	1 1 1 1 0 0 1 1 
	*	1 1 0 1 0 1 1 1 
	*	1 1 1 1 0 0 0 1 
	*	1 0 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 6 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + D
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 0 1 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 1 0 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	1 0 0 1 0 0 1 0 
*	1 0 1 1 1 0 1 0 	1 1 0 0 1 0 1 0 
*	0 0 1 1 0 1 1 0 	1 0 0 0 1 0 1 0 
*	0 0 0 1 1 1 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 1 1 1 0 1 	0 0 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_6_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hD));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 0 0 1 1 1 0 
	*	0 0 0 1 1 1 0 1 
	*	1 1 0 0 0 0 1 1 
	*	1 0 1 0 0 1 1 1 
	*	1 1 1 0 0 0 0 1 
	*	1 0 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 1 1 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 1 0 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 0 0 0 0 1 0 0 
*	1 0 1 1 0 1 1 0 	0 1 0 1 1 1 0 0 
*	0 0 0 1 0 0 0 0 	1 1 1 1 1 1 0 0 
*	1 1 1 1 0 0 1 0 	0 1 1 1 0 0 0 0 
*	1 0 0 0 1 1 0 1 	1 1 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[4];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 0 1 0 1 1 0 
	*	0 0 1 1 0 1 1 1 
	*	0 1 1 1 0 0 0 1 
	*	1 1 0 1 1 0 1 1 
	*	1 1 1 0 0 1 0 1 
	*	1 0 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 0 0 0 1 0 
*	0 1 1 1 0 0 1 0 	1 0 0 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 1 1 0 0 0 1 0 
*	1 1 0 1 1 1 0 0 	0 1 0 0 0 1 0 0 
*	0 0 0 1 0 1 1 0 	1 0 0 1 1 1 0 0 
*	0 1 1 0 0 0 1 0 	0 0 1 1 1 1 0 0 
*	0 1 0 1 1 1 1 0 	0 1 1 1 0 0 0 0 
*	0 1 0 1 0 0 0 1 	1 1 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[5] ^ in[1];
	assign inL[1] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 1 1 0 1 1 0 
	*	0 1 0 0 0 1 1 1 
	*	0 1 1 0 0 0 0 1 
	*	0 1 1 0 1 0 1 1 
	*	1 0 1 1 0 1 0 1 
	*	1 0 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 0 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 1 1 1 0 1 0 
*	0 0 0 1 0 1 0 0 	0 1 1 1 0 0 1 0 
*	1 0 0 0 0 0 1 0 	1 0 1 1 0 0 1 0 
*	0 0 0 0 0 1 1 0 	1 0 1 1 0 0 0 0 
*	0 1 1 1 0 0 0 1 	0 0 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[1];
	assign inL[1] = in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 1 1 1 1 1 0 
	*	1 1 0 1 1 0 1 1 
	*	1 1 0 1 0 1 0 1 
	*	0 0 1 1 1 0 0 1 
	*	1 0 1 1 1 1 1 1 
	*	1 0 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 1 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 1 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 0 1 1 0 1 0 
*	1 0 1 1 0 1 0 0 	0 1 0 1 0 0 1 0 
*	0 0 1 0 1 1 1 0 	1 0 0 1 0 0 1 0 
*	1 1 0 1 0 1 0 0 	1 0 1 1 0 0 0 0 
*	0 0 0 0 0 0 0 1 	0 0 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[2];
	assign inL[0] = in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 0 1 1 1 1 0 
	*	0 1 1 0 1 0 1 1 
	*	1 0 0 0 0 1 0 1 
	*	1 0 1 0 1 0 0 1 
	*	0 1 0 0 1 1 1 1 
	*	1 1 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 0 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 0 1 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 0 0 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 1 1 1 1 1 0 0 
*	0 0 0 1 1 0 1 0 	1 1 1 0 0 1 0 0 
*	0 1 1 1 0 1 1 0 	1 1 0 0 0 1 0 0 
*	0 0 1 1 1 0 1 0 	1 0 0 1 0 0 0 0 
*	1 0 1 0 1 0 0 1 	0 1 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 0 0 0 1 1 0 
	*	1 0 1 0 1 0 0 1 
	*	0 1 0 1 1 1 1 1 
	*	1 0 0 1 1 1 0 1 
	*	0 1 0 1 0 0 1 1 
	*	1 0 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 0 1 0 1 0 
*	1 1 0 1 0 0 1 0 	0 1 0 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 0 1 0 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 0 1 1 1 1 0 0 
*	1 0 1 1 1 0 1 0 	1 0 1 0 0 1 0 0 
*	1 0 1 0 0 1 0 0 	1 0 0 0 0 1 0 0 
*	0 0 1 1 0 1 1 0 	1 0 0 1 0 0 0 0 
*	0 0 0 0 1 0 1 1 	0 0 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[2];
	assign inL[1] = in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 1 0 0 1 1 0 
	*	0 0 1 1 1 0 0 1 
	*	1 0 1 0 1 1 1 1 
	*	0 1 0 0 1 1 0 1 
	*	0 1 1 0 0 0 1 1 
	*	0 1 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 0 0 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 1 1 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 0 0 1 0 0 1 0 
*	0 1 1 0 0 1 1 0 	0 1 1 1 1 0 1 0 
*	1 0 0 1 1 0 0 0 	0 0 1 1 1 0 1 0 
*	1 0 1 1 1 1 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 0 1 1 0 1 	1 1 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[4] ^ in[3];
	assign inL[1] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 1 0 1 1 1 0 
	*	0 1 0 0 1 1 0 1 
	*	0 0 1 1 0 0 1 1 
	*	0 1 0 0 0 1 1 1 
	*	1 0 0 1 0 0 0 1 
	*	0 1 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 7 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 0 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 1 1 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 0 1 0 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 0 1 1 0 0 1 0 
*	1 1 0 0 0 1 1 0 	1 1 0 1 1 0 1 0 
*	1 0 0 1 0 1 0 0 	1 0 0 1 1 0 1 0 
*	1 1 0 0 1 1 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 0 0 0 1 1 	0 0 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_7_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[4] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[3] ^ in[2];
	assign inL[0] = in[6] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 0 0 1 1 1 0 
	*	1 0 0 1 1 1 0 1 
	*	0 0 0 0 0 0 1 1 
	*	0 0 1 1 0 1 1 1 
	*	1 0 0 0 0 0 0 1 
	*	0 1 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 0 0 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 0 0 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 0 1 1 0 1 0 0 
*	0 1 1 0 1 0 0 0 	1 0 0 0 1 1 0 0 
*	1 1 0 0 0 0 0 0 	0 0 1 0 1 1 0 0 
*	0 1 0 1 1 1 0 0 	0 1 1 1 0 0 0 0 
*	0 1 0 1 1 1 1 1 	0 1 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[5] ^ in[3];
	assign inL[2] = in[7] ^ in[6];
	assign inL[1] = in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 1 1 0 1 1 0 
	*	0 0 0 1 0 1 1 1 
	*	1 0 1 1 0 0 0 1 
	*	0 0 1 0 1 0 1 1 
	*	1 0 0 1 0 1 0 1 
	*	0 1 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 1 1 0 0 1 0 
*	0 1 1 1 0 0 1 0 	0 1 1 1 0 1 1 0 
*	1 0 1 0 1 1 0 0 	1 0 1 1 0 0 1 0 
*	1 1 0 1 1 1 0 0 	1 1 1 1 0 1 0 0 
*	1 1 0 0 1 0 0 0 	0 1 0 0 1 1 0 0 
*	1 0 1 1 0 0 1 0 	1 1 1 0 1 1 0 0 
*	1 1 1 1 0 0 0 0 	0 1 1 1 0 0 0 0 
*	1 0 0 0 0 0 1 1 	0 1 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[3];
	assign inL[2] = in[7] ^ in[5] ^ in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4];
	assign inL[0] = in[7] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 1 1 1 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 0 1 0 1 1 0 
	*	0 1 1 0 0 1 1 1 
	*	1 0 1 0 0 0 0 1 
	*	1 0 0 1 1 0 1 1 
	*	1 1 0 0 0 1 0 1 
	*	0 1 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 0 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 0 0 1 0 1 0 
*	0 1 1 0 1 0 1 0 	0 0 1 0 0 0 1 0 
*	1 0 0 0 0 0 0 0 	1 1 1 0 0 0 1 0 
*	1 1 0 1 1 0 1 0 	1 0 1 1 0 0 0 0 
*	0 1 1 1 1 1 0 1 	1 1 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[7];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 1 1 1 1 1 0 
	*	0 0 1 0 1 0 1 1 
	*	1 0 1 0 0 1 0 1 
	*	1 0 0 1 1 0 0 1 
	*	1 1 1 1 1 1 1 1 
	*	1 1 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 1 1 1 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 1 0 1 0 1 0 
*	1 1 0 0 1 0 1 0 	0 0 0 0 0 0 1 0 
*	0 0 1 0 1 1 0 0 	1 1 0 0 0 0 1 0 
*	0 0 0 0 1 0 0 0 	1 0 1 1 0 0 0 0 
*	0 0 0 0 1 1 0 1 	1 1 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[1];
	assign inL[2] = in[5] ^ in[3] ^ in[2];
	assign inL[1] = in[3];
	assign inL[0] = in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 0 1 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 0 1 1 1 1 0 
	*	1 0 0 1 1 0 1 1 
	*	1 1 1 1 0 1 0 1 
	*	0 0 0 0 1 0 0 1 
	*	0 0 0 0 1 1 1 1 
	*	1 0 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outL[3] ^ outL[0];
	assign out[1] = ~( outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 0 0 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 0 1 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	1 0 0 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	0 1 1 0 1 1 0 0 
*	0 1 1 0 0 1 0 0 	0 0 0 1 0 1 0 0 
*	1 0 1 0 1 0 1 0 	0 0 1 1 0 1 0 0 
*	0 1 0 0 0 1 1 0 	1 0 0 1 0 0 0 0 
*	0 1 1 1 1 0 0 1 	0 1 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[2];
	assign inL[2] = in[7] ^ in[5] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 0 0 0 1 1 0 
	*	1 0 0 1 1 0 0 1 
	*	1 1 1 0 1 1 1 1 
	*	0 1 0 1 1 1 0 1 
	*	1 1 1 1 0 0 1 1 
	*	0 0 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 1 1 0 1 0 
*	1 1 0 1 0 0 1 0 	1 1 0 0 0 1 1 0 
*	0 0 0 0 1 1 0 0 	0 0 1 1 1 0 1 0 
*	1 0 1 0 0 0 1 0 	1 0 1 0 1 1 0 0 
*	1 1 0 0 0 1 0 0 	0 1 0 1 0 1 0 0 
*	0 1 1 1 1 0 0 0 	0 1 1 1 0 1 0 0 
*	0 1 0 0 1 0 1 0 	1 0 0 1 0 0 0 0 
*	1 1 0 1 1 0 1 1 	0 0 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[2];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[1] = in[6] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 1 1 1 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 1 0 0 1 1 0 
	*	0 0 0 0 1 0 0 1 
	*	0 0 0 1 1 1 1 1 
	*	1 0 0 0 1 1 0 1 
	*	1 1 0 0 0 0 1 1 
	*	1 1 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[2] ^ outL[1] );
	assign out[4] = outL[3] ^ outL[0];
	assign out[3] = outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	1 0 1 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	1 0 0 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	0 0 1 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 1 0 0 0 0 1 0 
*	0 0 0 1 1 0 0 0 	0 1 0 0 1 0 1 0 
*	1 1 1 0 0 1 0 0 	0 0 0 0 1 0 1 0 
*	0 0 0 1 1 1 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 0 0 0 0 1 	1 0 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[2];
	assign inL[1] = in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[6] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 1 0 1 1 1 0 
	*	0 1 0 1 1 1 0 1 
	*	1 0 1 0 0 0 1 1 
	*	0 1 1 0 0 1 1 1 
	*	0 1 0 1 0 0 0 1 
	*	1 1 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 1 - 8 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 0 0 0 0 	0 1 1 1 1 1 0 0 
*	0 0 0 0 1 1 0 0 	0 1 1 0 1 1 1 0 
*	0 1 1 1 0 0 1 0 	1 1 1 1 1 1 0 0 
*	1 0 1 0 1 1 1 0 	0 1 1 0 0 0 1 0 
*	1 0 1 1 1 0 0 0 	1 1 1 0 1 0 1 0 
*	1 1 1 0 1 0 0 0 	1 0 1 0 1 0 1 0 
*	0 1 1 0 1 1 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 0 1 1 1 1 	0 1 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_1_8_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3];
	assign inL[1] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr1 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul1 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul1 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv1_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul1 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul1 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 0 1 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 0 0 1 1 1 0 
	*	1 0 0 0 1 1 0 1 
	*	1 0 0 1 0 0 1 1 
	*	0 0 0 1 0 1 1 1 
	*	0 1 0 0 0 0 0 1 
	*	1 1 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outL[3] ^ outL[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 0 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 0 1 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 0 1 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 0 1 0 0 0 1 0 
*	0 1 0 0 1 0 0 0 	1 0 1 1 1 1 0 0 
*	0 0 1 1 1 1 0 0 	0 0 1 1 1 1 0 0 
*	0 1 1 0 0 0 1 0 	0 0 0 1 0 0 0 0 
*	0 1 1 0 1 1 0 1 	1 0 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[6] ^ in[3];
	assign inL[2] = in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[6] ^ in[5] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 0 1 0 1 0 0 
	*	0 0 1 0 0 0 0 1 
	*	0 1 0 0 0 1 0 1 
	*	0 1 0 0 1 1 0 1 
	*	1 1 0 1 0 1 1 1 
	*	1 1 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[2] );
	assign out[4] = outH[1] ^ outL[0];
	assign out[3] = outH[2] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 1 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 1 1 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 1 0 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 0 0 0 0 0 1 0 
*	0 1 0 0 0 1 0 0 	0 1 1 1 1 1 0 0 
*	1 1 1 0 0 0 1 0 	1 1 1 1 1 1 0 0 
*	0 0 0 1 0 0 0 0 	0 0 0 1 0 0 0 0 
*	0 1 1 0 1 1 1 1 	1 0 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[6] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[1];
	assign inL[1] = in[4];
	assign inL[0] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 0 1 0 1 0 0 
	*	0 0 1 1 0 0 0 1 
	*	0 0 0 1 0 1 0 1 
	*	1 0 0 1 1 1 0 1 
	*	1 0 1 0 0 1 1 1 
	*	1 0 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[0];
	assign out[3] = outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 0 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 0 1 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 0 1 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 1 0 1 1 0 0 0 
*	0 0 0 1 0 0 1 0 	0 0 0 1 0 1 1 0 
*	1 0 0 0 0 1 0 0 	1 1 0 1 0 1 1 0 
*	1 0 0 0 0 0 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 0 1 0 1 	0 1 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[1];
	assign inL[2] = in[7] ^ in[2];
	assign inL[1] = in[7] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 1 1 1 0 1 0 
	*	1 0 0 1 1 1 0 1 
	*	1 0 0 1 0 1 1 1 
	*	0 0 1 1 1 0 1 1 
	*	1 1 0 1 1 1 1 1 
	*	1 1 0 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 1 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 0 0 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 0 0 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 1 0 1 1 0 0 0 
*	0 1 1 0 0 0 0 0 	0 1 1 1 0 1 1 0 
*	1 1 1 1 1 0 1 0 	1 0 1 1 0 1 1 0 
*	0 0 1 0 1 1 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 1 0 1 1 	0 0 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 0 1 1 0 1 0 
	*	0 1 0 0 1 1 0 1 
	*	1 1 1 0 0 1 1 1 
	*	1 0 0 0 1 0 1 1 
	*	0 0 1 0 1 1 1 1 
	*	1 0 1 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 1 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 0 1 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 0 0 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 1 0 1 1 1 0 0 
*	1 0 0 0 1 1 0 0 	1 0 0 0 0 0 1 0 
*	1 0 0 1 0 0 1 0 	1 1 1 0 0 0 1 0 
*	1 0 1 0 0 1 0 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 1 0 0 1 	0 0 1 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[2];
	assign inL[0] = in[7] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 0 0 0 0 1 0 0 
	*	0 0 1 1 1 0 1 1 
	*	1 0 0 0 1 1 1 1 
	*	0 0 1 0 1 0 0 1 
	*	0 1 0 0 0 0 1 1 
	*	0 0 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outL[2] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 1 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 1 1 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 0 0 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 0 0 1 1 1 0 0 
*	0 0 1 0 0 0 0 0 	1 0 1 0 0 0 1 0 
*	0 1 0 0 1 1 0 0 	1 1 0 0 0 0 1 0 
*	0 1 1 1 0 1 1 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 0 1 0 1 	0 1 0 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5];
	assign inL[2] = in[6] ^ in[3] ^ in[2];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 1 0 0 0 1 0 0 
	*	1 0 0 0 1 0 1 1 
	*	0 1 1 1 1 1 1 1 
	*	1 0 1 1 1 0 0 1 
	*	0 1 1 1 0 0 1 1 
	*	1 1 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[2] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 1 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 1 0 1 0 1 1 0 
*	1 1 0 1 1 0 0 0 	0 0 0 1 1 0 0 0 
*	0 0 1 0 0 1 1 0 	0 0 1 1 1 0 0 0 
*	1 0 0 1 1 0 0 0 	1 0 0 1 0 0 0 0 
*	1 1 0 0 1 0 1 1 	1 1 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[3];
	assign inL[2] = in[5] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[6] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 0 0 1 0 1 0 
	*	0 0 1 0 1 0 0 1 
	*	0 0 1 1 0 0 1 1 
	*	0 0 1 0 0 0 0 1 
	*	1 0 1 1 0 1 0 1 
	*	0 1 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 1 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 1 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 0 1 1 0 1 1 0 
*	0 0 0 0 1 0 1 0 	1 0 0 1 1 0 0 0 
*	0 1 0 1 1 0 0 0 	1 0 1 1 1 0 0 0 
*	1 0 0 1 0 1 0 0 	1 0 0 1 0 0 0 0 
*	0 0 0 1 1 0 1 1 	0 0 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_1_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[4] ^ in[3];
	assign inL[1] = in[7] ^ in[4] ^ in[2];
	assign inL[0] = in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 1 0 1 0 1 0 
	*	1 0 1 1 1 0 0 1 
	*	0 0 0 0 0 0 1 1 
	*	0 0 1 1 0 0 0 1 
	*	1 1 1 0 0 1 0 1 
	*	0 1 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 0 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 1 0 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 0 1 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 1 0 1 0 0 1 0 
*	0 0 1 1 0 1 0 0 	1 1 1 0 1 1 0 0 
*	1 0 0 1 1 1 0 0 	0 1 1 0 1 1 0 0 
*	1 1 0 0 0 0 0 0 	0 0 0 1 0 0 0 0 
*	1 1 0 0 0 0 1 1 	0 0 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[6];
	assign inL[0] = in[7] ^ in[6] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 1 1 0 1 0 0 
	*	0 1 0 1 0 0 0 1 
	*	1 1 0 1 0 1 0 1 
	*	0 1 1 0 1 1 0 1 
	*	1 0 1 1 0 1 1 1 
	*	0 1 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 1 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 0 0 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 1 0 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 1 1 1 0 0 1 0 
*	0 0 1 1 1 0 0 0 	0 0 1 0 1 1 0 0 
*	0 1 0 0 0 0 1 0 	1 0 1 0 1 1 0 0 
*	1 0 1 1 0 0 1 0 	0 0 0 1 0 0 0 0 
*	1 1 0 0 0 0 0 1 	0 0 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[6] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 1 1 0 1 0 0 
	*	0 1 0 0 0 0 0 1 
	*	1 0 0 0 0 1 0 1 
	*	1 0 1 1 1 1 0 1 
	*	1 1 0 0 0 1 1 1 
	*	0 0 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[2] ^ outL[0];
	assign out[3] = outH[3] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 0 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 1 0 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 1 1 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 1 1 0 1 0 0 0 
*	1 0 1 1 0 0 0 0 	0 1 1 0 0 1 1 0 
*	0 1 0 1 1 0 1 0 	1 0 1 0 0 1 1 0 
*	1 0 0 0 0 0 0 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 0 1 1 1 	1 0 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4];
	assign inL[2] = in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[7];
	assign inL[0] = in[5] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 0 1 1 0 1 0 
	*	0 1 1 0 1 1 0 1 
	*	1 0 0 0 0 1 1 1 
	*	1 0 1 1 1 0 1 1 
	*	1 1 1 1 1 1 1 1 
	*	1 1 0 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 1 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 1 1 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 1 0 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 1 1 0 1 0 0 0 
*	1 1 0 0 0 0 1 0 	0 0 0 0 0 1 1 0 
*	0 0 1 0 0 1 0 0 	1 1 0 0 0 1 1 0 
*	0 0 1 0 1 1 0 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 1 0 0 1 	1 1 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[1];
	assign inL[2] = in[5] ^ in[2];
	assign inL[1] = in[5] ^ in[3] ^ in[2];
	assign inL[0] = in[5] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 1 1 1 0 1 0 
	*	1 0 1 1 1 1 0 1 
	*	1 1 1 1 0 1 1 1 
	*	0 0 0 0 1 0 1 1 
	*	0 0 0 0 1 1 1 1 
	*	1 0 1 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 0 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 0 0 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 0 1 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 1 0 0 1 1 0 0 
*	0 0 1 0 0 0 1 0 	0 1 0 1 0 0 1 0 
*	1 1 1 0 1 1 0 0 	0 0 1 1 0 0 1 0 
*	1 0 1 0 1 0 1 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 0 1 0 1 	0 0 1 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[5] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 0 1 0 0 1 0 0 
	*	1 0 1 1 1 0 1 1 
	*	1 0 1 0 1 1 1 1 
	*	0 1 1 1 1 0 0 1 
	*	1 1 1 1 0 0 1 1 
	*	0 0 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[1] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 0 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 1 0 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 0 1 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 0 0 0 1 1 0 0 
*	1 0 0 0 1 1 1 0 	0 1 1 1 0 0 1 0 
*	0 0 1 1 0 0 1 0 	0 0 0 1 0 0 1 0 
*	0 1 1 1 1 0 0 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 1 0 0 1 	0 1 0 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[5] ^ in[4] ^ in[1];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 1 1 0 0 1 0 0 
	*	0 0 0 0 1 0 1 1 
	*	0 1 0 1 1 1 1 1 
	*	1 1 1 0 1 0 0 1 
	*	1 1 0 0 0 0 1 1 
	*	1 1 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[2] );
	assign out[4] = outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 1 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 1 0 0 0 1 1 0 
*	1 1 0 1 0 1 1 0 	1 0 1 0 1 0 0 0 
*	1 0 0 0 0 1 1 0 	1 0 0 0 1 0 0 0 
*	1 1 1 0 1 0 0 0 	1 0 0 1 0 0 0 0 
*	0 1 1 0 1 0 0 1 	0 0 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3];
	assign inL[0] = in[6] ^ in[5] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 0 0 1 0 1 0 
	*	1 1 1 0 1 0 0 1 
	*	1 0 1 1 0 0 1 1 
	*	0 1 0 1 0 0 0 1 
	*	0 0 1 0 0 1 0 1 
	*	1 1 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 2 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 1 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 0 1 0 0 1 1 0 
*	0 0 0 0 0 1 0 0 	0 0 1 0 1 0 0 0 
*	1 1 1 1 1 0 0 0 	0 0 0 0 1 0 0 0 
*	1 1 1 0 0 1 0 0 	1 0 0 1 0 0 0 0 
*	1 0 1 1 1 0 0 1 	1 1 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_2_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 1 0 1 0 1 0 
	*	0 1 1 1 1 0 0 1 
	*	1 0 0 0 0 0 1 1 
	*	0 1 0 0 0 0 0 1 
	*	0 1 1 1 0 1 0 1 
	*	1 1 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 0 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 1 0 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 1 1 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 0 0 1 0 0 1 0 
*	1 0 0 1 0 1 1 0 	1 0 0 1 1 1 0 0 
*	1 0 0 1 0 0 0 0 	0 0 0 1 1 1 0 0 
*	0 0 0 1 0 0 1 0 	0 0 0 1 0 0 0 0 
*	0 1 1 0 0 0 1 1 	0 0 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[4];
	assign inL[1] = in[4] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 1 1 0 1 0 0 
	*	1 0 1 1 0 0 0 1 
	*	1 0 1 1 0 1 0 1 
	*	1 1 1 1 1 1 0 1 
	*	0 0 0 1 0 1 1 1 
	*	0 0 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 1 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 0 0 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 0 0 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 0 1 1 0 0 1 0 
*	1 0 0 1 1 0 1 0 	0 1 0 1 1 1 0 0 
*	0 1 0 0 1 1 1 0 	1 1 0 1 1 1 0 0 
*	0 1 1 0 0 0 0 0 	0 0 0 1 0 0 0 0 
*	0 1 1 0 0 0 0 1 	0 0 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[5];
	assign inL[0] = in[6] ^ in[5] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 1 1 0 1 0 0 
	*	1 0 1 0 0 0 0 1 
	*	1 1 1 0 0 1 0 1 
	*	0 0 1 0 1 1 0 1 
	*	0 1 1 0 0 1 1 1 
	*	0 1 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 0 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 1 1 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 0 1 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 0 0 1 1 0 0 0 
*	0 0 0 1 1 1 1 0 	0 0 1 0 0 1 1 0 
*	0 0 1 0 1 0 0 0 	1 1 1 0 0 1 1 0 
*	1 0 0 0 1 1 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 0 1 1 1 	1 1 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[5] ^ in[3];
	assign inL[1] = in[7] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 1 0 1 0 1 0 
	*	1 1 1 1 1 1 0 1 
	*	0 0 1 0 0 1 1 1 
	*	0 1 1 0 1 0 1 1 
	*	1 0 1 0 1 1 1 1 
	*	0 1 1 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 1 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 1 0 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 0 0 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 0 0 1 1 0 0 0 
*	0 1 1 0 1 1 0 0 	0 1 0 0 0 1 1 0 
*	0 1 0 1 0 1 1 0 	1 0 0 0 0 1 1 0 
*	0 0 1 0 0 0 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 1 0 0 1 	1 0 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[2] = in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[5];
	assign inL[0] = in[7] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 0 0 1 0 1 0 
	*	0 0 1 0 1 1 0 1 
	*	0 1 0 1 0 1 1 1 
	*	1 1 0 1 1 0 1 1 
	*	0 1 0 1 1 1 1 1 
	*	0 0 0 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 1 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 0 0 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 1 0 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 0 1 1 1 1 0 0 
*	1 1 1 1 1 1 1 0 	1 0 0 1 0 0 1 0 
*	0 1 0 0 0 0 0 0 	1 1 1 1 0 0 1 0 
*	1 1 0 1 1 0 0 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 0 1 0 1 	1 0 0 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[6];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[3];
	assign inL[0] = in[5] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 0 1 0 0 1 0 0 
	*	0 1 1 0 1 0 1 1 
	*	1 1 1 1 1 1 1 1 
	*	0 1 1 0 1 0 0 1 
	*	1 1 0 1 0 0 1 1 
	*	0 1 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 1 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 1 0 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 1 0 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 1 1 1 1 1 0 0 
*	0 1 0 1 0 0 1 0 	1 0 1 1 0 0 1 0 
*	1 0 0 1 1 1 1 0 	1 1 0 1 0 0 1 0 
*	0 0 0 0 1 0 1 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 1 0 0 1 	1 1 1 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4] ^ in[1];
	assign inL[2] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[3] ^ in[1];
	assign inL[0] = in[6] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 1 1 0 0 1 0 0 
	*	1 1 0 1 1 0 1 1 
	*	0 0 0 0 1 1 1 1 
	*	1 1 1 1 1 0 0 1 
	*	1 1 1 0 0 0 1 1 
	*	1 0 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 0 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 1 1 0 0 1 1 0 
*	0 1 1 1 0 1 0 0 	1 1 0 1 1 0 0 0 
*	0 0 1 0 1 0 1 0 	1 1 1 1 1 0 0 0 
*	0 1 0 0 1 0 0 0 	1 0 0 1 0 0 0 0 
*	0 0 0 1 1 0 0 1 	1 0 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[5] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[3];
	assign inL[0] = in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 0 1 1 0 1 0 
	*	0 1 1 0 1 0 0 1 
	*	1 0 1 0 0 0 1 1 
	*	1 0 1 0 0 0 0 1 
	*	0 0 0 1 0 1 0 1 
	*	1 1 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 3 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 0 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 0 0 0 0 1 1 0 
*	1 0 1 0 0 1 1 0 	0 1 0 1 1 0 0 0 
*	0 1 0 1 0 1 0 0 	0 1 1 1 1 0 0 0 
*	0 1 0 0 0 1 0 0 	1 0 0 1 0 0 0 0 
*	1 1 0 0 1 0 0 1 	0 1 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_3_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[4] ^ in[2];
	assign inL[1] = in[6] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 1 1 1 0 1 0 
	*	1 1 1 1 1 0 0 1 
	*	1 0 0 1 0 0 1 1 
	*	1 0 1 1 0 0 0 1 
	*	0 1 0 0 0 1 0 1 
	*	1 1 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 0 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 0 1 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 1 1 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 1 1 0 0 0 1 0 
*	1 1 1 0 1 0 1 0 	1 1 0 0 1 1 0 0 
*	0 0 1 1 0 0 0 0 	0 1 0 0 1 1 0 0 
*	1 0 1 1 0 0 0 0 	0 0 0 1 0 0 0 0 
*	1 1 0 0 1 1 0 1 	1 0 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[5] ^ in[4];
	assign inL[1] = in[7] ^ in[5] ^ in[4];
	assign inL[0] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 0 1 0 1 0 0 
	*	1 1 0 0 0 0 0 1 
	*	0 0 1 0 0 1 0 1 
	*	1 1 0 1 1 1 0 1 
	*	0 1 1 1 0 1 1 1 
	*	1 0 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[0];
	assign out[3] = outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 1 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 1 1 1 0 1 0 0 
*	0 1 1 1 0 0 1 0 	1 0 0 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 1 0 0 0 0 1 0 
*	1 1 1 0 0 1 1 0 	0 0 0 0 1 1 0 0 
*	1 1 1 0 1 1 1 0 	1 0 0 0 1 1 0 0 
*	1 1 0 0 0 0 1 0 	0 0 0 1 0 0 0 0 
*	1 1 0 0 1 1 1 1 	1 0 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 0 1 0 1 0 0 
	*	1 1 0 1 0 0 0 1 
	*	0 1 1 1 0 1 0 1 
	*	0 0 0 0 1 1 0 1 
	*	0 0 0 0 0 1 1 1 
	*	1 1 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 0 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 0 0 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 1 1 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 0 1 0 1 0 0 0 
*	1 0 1 1 1 1 0 0 	0 1 0 1 0 1 1 0 
*	1 1 1 1 0 1 1 0 	1 0 0 1 0 1 1 0 
*	1 0 0 0 1 1 1 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 0 1 0 1 	0 0 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 0 0 1 0 1 0 
	*	0 0 0 0 1 1 0 1 
	*	0 0 1 1 0 1 1 1 
	*	1 1 1 0 1 0 1 1 
	*	1 0 0 0 1 1 1 1 
	*	0 1 1 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[1] );
	assign out[4] = outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 1 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 0 1 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 1 0 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 0 1 0 1 0 0 0 
*	1 1 0 0 1 1 1 0 	0 0 1 1 0 1 1 0 
*	1 0 0 0 1 0 0 0 	1 1 1 1 0 1 1 0 
*	0 0 1 0 0 0 1 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 1 0 1 1 	0 1 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[3];
	assign inL[1] = in[5] ^ in[1];
	assign inL[0] = in[6] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 1 0 1 0 1 0 
	*	1 1 0 1 1 1 0 1 
	*	0 1 0 0 0 1 1 1 
	*	0 1 0 1 1 0 1 1 
	*	0 1 1 1 1 1 1 1 
	*	0 0 0 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 0 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 0 1 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 1 1 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 0 1 0 1 1 0 0 
*	0 1 0 1 0 0 0 0 	0 1 0 0 0 0 1 0 
*	0 0 1 1 1 1 1 0 	0 0 1 0 0 0 1 0 
*	1 1 0 1 0 1 1 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 1 0 0 1 	1 0 0 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4];
	assign inL[2] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 0 0 0 0 1 0 0 
	*	1 1 1 0 1 0 1 1 
	*	1 1 0 1 1 1 1 1 
	*	0 0 1 1 1 0 0 1 
	*	0 1 1 0 0 0 1 1 
	*	0 1 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 0 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 1 1 0 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 1 1 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 1 1 0 1 1 0 0 
*	1 1 1 1 1 1 0 0 	0 1 1 0 0 0 1 0 
*	1 1 1 0 0 0 0 0 	0 0 0 0 0 0 1 0 
*	0 0 0 0 0 1 0 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 0 1 0 1 	1 1 1 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5];
	assign inL[1] = in[2];
	assign inL[0] = in[6] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 1 0 0 0 1 0 0 
	*	0 1 0 1 1 0 1 1 
	*	0 0 1 0 1 1 1 1 
	*	1 0 1 0 1 0 0 1 
	*	0 1 0 1 0 0 1 1 
	*	1 0 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[2] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 0 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 1 1 1 0 1 1 0 
*	0 1 1 1 1 0 1 0 	0 1 1 0 1 0 0 0 
*	1 0 0 0 1 0 1 0 	0 1 0 0 1 0 0 0 
*	0 0 1 1 1 0 0 0 	1 0 0 1 0 0 0 0 
*	1 0 1 1 1 0 1 1 	0 1 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[3] ^ in[1];
	assign inL[1] = in[5] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 0 1 1 0 1 0 
	*	1 0 1 0 1 0 0 1 
	*	0 0 1 0 0 0 1 1 
	*	1 1 0 1 0 0 0 1 
	*	1 0 0 0 0 1 0 1 
	*	0 1 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[3] = outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 4 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 0 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	0 0 0 1 0 1 1 0 
*	1 0 1 0 1 0 0 0 	1 1 1 0 1 0 0 0 
*	1 1 1 1 0 1 0 0 	1 1 0 0 1 0 0 0 
*	0 0 1 1 0 1 0 0 	1 0 0 1 0 0 0 0 
*	0 1 1 0 1 0 1 1 	1 0 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_4_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[1] = in[5] ^ in[4] ^ in[2];
	assign inL[0] = in[6] ^ in[5] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 1 1 1 0 1 0 
	*	0 0 1 1 1 0 0 1 
	*	0 0 0 1 0 0 1 1 
	*	1 1 0 0 0 0 0 1 
	*	1 1 0 1 0 1 0 1 
	*	0 1 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 0 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 0 1 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 1 1 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 1 1 0 0 0 1 0 
*	0 1 0 0 1 0 1 0 	0 0 1 1 1 1 0 0 
*	0 0 1 1 0 0 1 0 	1 0 1 1 1 1 0 0 
*	1 0 1 1 1 1 0 0 	0 0 0 1 0 0 0 0 
*	0 0 0 1 1 1 1 1 	1 1 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[6] ^ in[3] ^ in[1];
	assign inL[2] = in[5] ^ in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 0 0 0 1 0 0 
	*	0 0 0 0 0 0 0 1 
	*	1 1 1 1 0 1 0 1 
	*	1 1 1 0 1 1 0 1 
	*	0 0 1 0 0 1 1 1 
	*	0 1 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[2] );
	assign out[4] = outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 1 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 1 1 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 0 0 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 1 0 0 0 0 1 0 
*	0 1 0 0 0 1 1 0 	1 1 1 1 1 1 0 0 
*	1 1 1 0 1 1 0 0 	0 1 1 1 1 1 0 0 
*	1 1 0 0 1 1 1 0 	0 0 0 1 0 0 0 0 
*	0 0 0 1 1 1 0 1 	1 1 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[6] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 0 0 0 1 0 0 
	*	0 0 0 1 0 0 0 1 
	*	1 0 1 0 0 1 0 1 
	*	0 0 1 1 1 1 0 1 
	*	0 1 0 1 0 1 1 1 
	*	0 0 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[2] );
	assign out[4] = outH[0] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 0 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 1 1 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 1 1 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 1 0 0 1 0 0 0 
*	0 0 0 1 1 1 0 0 	1 1 0 0 0 1 1 0 
*	1 1 1 1 1 0 0 0 	0 0 0 0 0 1 1 0 
*	1 1 1 1 1 1 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 1 0 0 1 	1 1 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[6] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 1 0 1 0 1 0 
	*	0 0 1 1 1 1 0 1 
	*	0 1 1 0 0 1 1 1 
	*	0 1 0 0 1 0 1 1 
	*	0 0 1 1 1 1 1 1 
	*	0 0 1 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 1 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 1 0 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 1 0 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 1 0 0 1 0 0 0 
*	0 1 1 0 1 1 1 0 	1 0 1 0 0 1 1 0 
*	1 0 0 0 0 1 1 0 	0 1 1 0 0 1 1 0 
*	0 1 0 1 0 0 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 0 1 1 1 	1 0 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[4];
	assign inL[0] = in[6] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 0 0 1 0 1 0 
	*	1 1 1 0 1 1 0 1 
	*	0 0 0 1 0 1 1 1 
	*	1 1 1 1 1 0 1 1 
	*	1 1 0 0 1 1 1 1 
	*	0 1 0 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 1 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 0 1 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 0 0 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 1 0 1 1 1 0 0 
*	1 1 1 1 0 0 0 0 	1 1 0 0 0 0 1 0 
*	0 1 0 0 0 0 1 0 	1 0 1 0 0 0 1 0 
*	0 1 1 1 1 0 1 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 1 0 1 1 	1 1 0 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4];
	assign inL[2] = in[6] ^ in[1];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[6] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 0 0 1 0 1 0 0 
	*	0 1 0 0 1 0 1 1 
	*	0 1 1 0 1 1 1 1 
	*	0 0 0 1 1 0 0 1 
	*	0 0 1 0 0 0 1 1 
	*	1 1 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[0] ^ outL[2] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 1 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 1 1 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 0 0 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 0 0 1 1 1 0 0 
*	0 1 0 1 1 1 0 0 	1 1 1 0 0 0 1 0 
*	1 0 0 1 1 1 0 0 	1 0 0 0 0 0 1 0 
*	1 0 1 0 1 0 0 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 0 1 1 1 	1 0 1 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[5] ^ in[3];
	assign inL[0] = in[5] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 1 0 1 0 1 0 0 
	*	1 1 1 1 1 0 1 1 
	*	1 0 0 1 1 1 1 1 
	*	1 0 0 0 1 0 0 1 
	*	0 0 0 1 0 0 1 1 
	*	0 0 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 1 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 0 0 0 0 1 1 0 
*	0 0 0 0 1 0 0 0 	0 0 0 0 1 0 0 0 
*	0 0 1 0 0 1 0 0 	0 0 1 0 1 0 0 0 
*	1 1 1 0 0 1 1 0 	1 0 0 1 0 0 0 0 
*	1 1 0 0 0 1 1 1 	0 0 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[3];
	assign inL[2] = in[5] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 0 1 1 0 1 0 
	*	0 0 0 1 1 0 0 1 
	*	0 1 0 1 0 0 1 1 
	*	0 0 0 0 0 0 0 1 
	*	0 0 0 0 0 1 0 1 
	*	0 0 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outL[0];
	assign out[1] = ~( outL[2] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 5 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 1 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 1 1 0 0 1 1 0 
*	1 1 0 1 1 0 1 0 	1 0 0 0 1 0 0 0 
*	0 1 0 1 1 0 1 0 	1 0 1 0 1 0 0 0 
*	1 1 1 0 1 0 1 0 	1 0 0 1 0 0 0 0 
*	0 0 0 1 0 1 1 1 	1 1 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_5_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[0] = in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 1 1 1 0 1 0 
	*	1 0 0 0 1 0 0 1 
	*	0 1 1 0 0 0 1 1 
	*	0 0 0 1 0 0 0 1 
	*	0 1 0 1 0 1 0 1 
	*	0 0 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[0] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 0 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 1 0 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 1 1 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 0 0 1 0 0 1 0 
*	0 0 1 1 0 1 1 0 	0 1 1 0 1 1 0 0 
*	1 0 0 1 0 0 1 0 	1 1 1 0 1 1 0 0 
*	0 0 0 1 1 1 1 0 	0 0 0 1 0 0 0 0 
*	1 0 1 1 0 0 0 1 	0 1 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[4] ^ in[1];
	assign inL[1] = in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 1 0 0 1 0 0 
	*	0 1 1 1 0 0 0 1 
	*	0 1 1 0 0 1 0 1 
	*	1 1 0 0 1 1 0 1 
	*	0 1 0 0 0 1 1 1 
	*	1 1 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 1 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 0 0 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 0 0 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 0 1 1 0 0 1 0 
*	0 0 1 1 1 0 1 0 	1 0 1 0 1 1 0 0 
*	0 1 0 0 1 1 0 0 	0 0 1 0 1 1 0 0 
*	0 1 1 0 1 1 0 0 	0 0 0 1 0 0 0 0 
*	1 0 1 1 0 0 1 1 	0 1 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[3] ^ in[2];
	assign inL[1] = in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 1 0 0 1 0 0 
	*	0 1 1 0 0 0 0 1 
	*	0 0 1 1 0 1 0 1 
	*	0 0 0 1 1 1 0 1 
	*	0 0 1 1 0 1 1 1 
	*	1 0 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 0 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 0 0 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 0 1 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 1 1 1 1 0 0 0 
*	1 0 1 1 1 1 1 0 	1 0 1 1 0 1 1 0 
*	0 0 1 0 0 1 1 0 	0 1 1 1 0 1 1 0 
*	1 1 1 1 1 1 1 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 1 0 1 1 	0 0 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[5] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 0 0 1 0 1 0 
	*	1 1 0 0 1 1 0 1 
	*	0 1 1 1 0 1 1 1 
	*	1 1 0 0 1 0 1 1 
	*	0 0 0 1 1 1 1 1 
	*	0 0 1 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 1 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 0 1 0 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 0 0 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 1 1 1 1 0 0 0 
*	1 1 0 0 1 1 0 0 	1 1 0 1 0 1 1 0 
*	0 1 0 1 1 0 0 0 	0 0 0 1 0 1 1 0 
*	0 1 0 1 0 0 1 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 0 1 0 1 	0 1 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[2];
	assign inL[2] = in[6] ^ in[4] ^ in[3];
	assign inL[1] = in[6] ^ in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 1 0 1 0 1 0 
	*	0 0 0 1 1 1 0 1 
	*	0 0 0 0 0 1 1 1 
	*	0 1 1 1 1 0 1 1 
	*	1 1 1 0 1 1 1 1 
	*	0 1 0 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 0 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 0 0 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 0 1 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 1 0 0 1 1 0 0 
*	0 1 0 1 1 1 1 0 	0 0 0 1 0 0 1 0 
*	0 0 1 1 1 1 0 0 	0 1 1 1 0 0 1 0 
*	0 1 1 1 0 1 0 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 0 1 1 1 	1 1 0 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[0] = in[6] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 0 1 1 0 1 0 0 
	*	1 1 0 0 1 0 1 1 
	*	0 1 0 0 1 1 1 1 
	*	0 1 0 0 1 0 0 1 
	*	1 0 0 1 0 0 1 1 
	*	1 1 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 0 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 1 0 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 0 1 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 0 0 0 1 1 0 0 
*	1 1 1 1 0 0 1 0 	0 0 1 1 0 0 1 0 
*	1 1 1 0 0 0 1 0 	0 1 0 1 0 0 1 0 
*	1 0 1 0 0 1 1 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 1 0 1 1 	1 0 1 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[1];
	assign inL[1] = in[7] ^ in[5] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 1 1 1 0 1 0 0 
	*	0 1 1 1 1 0 1 1 
	*	1 0 1 1 1 1 1 1 
	*	1 1 0 1 1 0 0 1 
	*	1 0 1 0 0 0 1 1 
	*	0 0 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 1 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 0 0 1 0 1 1 0 
*	0 0 0 0 0 1 1 0 	1 0 1 1 1 0 0 0 
*	1 0 0 0 0 1 0 0 	1 0 0 1 1 0 0 0 
*	1 0 0 1 0 1 1 0 	1 0 0 1 0 0 0 0 
*	0 1 1 0 0 1 0 1 	1 1 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[2];
	assign inL[1] = in[7] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 0 1 1 0 1 0 
	*	1 1 0 1 1 0 0 1 
	*	1 1 0 1 0 0 1 1 
	*	0 1 1 1 0 0 0 1 
	*	1 0 0 1 0 1 0 1 
	*	1 0 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 6 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 1 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 1 1 1 0 1 1 0 
*	1 1 0 1 0 1 0 0 	0 0 1 1 1 0 0 0 
*	1 1 1 1 1 0 1 0 	0 0 0 1 1 0 0 0 
*	1 0 0 1 1 0 1 0 	1 0 0 1 0 0 0 0 
*	1 0 1 1 0 1 0 1 	0 0 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_6_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 1 1 1 0 1 0 
	*	0 1 0 0 1 0 0 1 
	*	1 1 1 0 0 0 1 1 
	*	0 1 1 0 0 0 0 1 
	*	1 1 0 0 0 1 0 1 
	*	1 0 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 0 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 1 0 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 0 1 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 1 0 1 0 0 1 0 
*	1 0 0 1 0 1 0 0 	0 0 0 1 1 1 0 0 
*	1 0 0 1 1 1 1 0 	1 0 0 1 1 1 0 0 
*	1 1 0 0 1 1 0 0 	0 0 0 1 0 0 0 0 
*	0 0 0 1 0 0 0 1 	0 1 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[3] ^ in[2];
	assign inL[0] = in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 1 0 0 1 0 0 
	*	1 0 0 1 0 0 0 1 
	*	0 0 0 0 0 1 0 1 
	*	0 1 0 1 1 1 0 1 
	*	1 1 1 0 0 1 1 1 
	*	1 0 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[0];
	assign out[3] = outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 1 0 0 1 1 0 
*	1 1 0 1 1 1 1 0 	0 0 0 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 1 0 0 0 1 1 0 
*	0 0 0 0 0 0 1 0 	0 1 1 1 0 0 1 0 
*	1 0 0 1 1 0 0 0 	1 1 0 1 1 1 0 0 
*	0 1 0 0 0 0 0 0 	0 1 0 1 1 1 0 0 
*	1 0 1 1 1 1 1 0 	0 0 0 1 0 0 0 0 
*	0 0 0 1 0 0 1 1 	0 1 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[3];
	assign inL[2] = in[6];
	assign inL[1] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 1 0 0 1 0 0 
	*	1 0 0 0 0 0 0 1 
	*	0 1 0 1 0 1 0 1 
	*	1 0 0 0 1 1 0 1 
	*	1 0 0 1 0 1 1 1 
	*	1 1 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[2] );
	assign out[4] = outH[3] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 0 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 0 1 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 1 1 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 0 0 0 1 0 0 0 
*	0 0 0 1 0 0 0 0 	1 1 1 1 0 1 1 0 
*	0 1 0 1 0 1 0 0 	0 0 1 1 0 1 1 0 
*	1 1 1 1 0 0 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 1 0 1 1 	0 1 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4];
	assign inL[2] = in[6] ^ in[4] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inL[0] = in[5] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 1 1 1 1 0 1 0 
	*	0 1 0 1 1 1 0 1 
	*	1 1 0 1 0 1 1 1 
	*	0 0 0 1 1 0 1 1 
	*	0 1 0 0 1 1 1 1 
	*	1 0 0 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 1 0 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 0 0 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	0 1 0 0 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 0 0 0 1 0 0 0 
*	0 1 1 0 0 0 1 0 	1 0 0 1 0 1 1 0 
*	0 0 1 0 1 0 1 0 	0 1 0 1 0 1 1 0 
*	0 1 0 1 1 1 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 0 1 0 1 	0 0 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[1];
	assign inL[2] = in[5] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 1 0 1 1 0 1 0 
	*	1 0 0 0 1 1 0 1 
	*	1 0 1 0 0 1 1 1 
	*	1 0 1 0 1 0 1 1 
	*	1 0 1 1 1 1 1 1 
	*	1 1 1 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 1 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 0 0 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 1 0 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 0 1 1 1 1 0 0 
*	1 0 0 0 0 0 1 0 	1 1 0 1 0 0 1 0 
*	1 0 0 1 0 0 0 0 	1 0 1 1 0 0 1 0 
*	0 0 0 0 0 1 1 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 0 1 1 1 	0 1 1 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[1];
	assign inL[2] = in[7] ^ in[4];
	assign inL[1] = in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 0 1 1 0 1 0 0 
	*	0 0 0 1 1 0 1 1 
	*	0 0 0 1 1 1 1 1 
	*	0 1 0 1 1 0 0 1 
	*	1 0 1 1 0 0 1 1 
	*	1 0 1 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 1 1 1 0 0 0 
*	1 1 0 1 1 1 1 0 	1 1 0 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 1 0 1 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 1 1 1 1 1 0 0 
*	0 0 1 0 1 1 1 0 	1 1 1 1 0 0 1 0 
*	0 1 0 0 1 1 1 0 	1 0 0 1 0 0 1 0 
*	1 1 0 1 0 1 0 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 1 0 1 1 	0 0 0 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[2];
	assign inL[0] = in[7] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	0 1 1 1 0 1 0 0 
	*	1 0 1 0 1 0 1 1 
	*	1 1 1 0 1 1 1 1 
	*	1 1 0 0 1 0 0 1 
	*	1 0 0 0 0 0 1 1 
	*	0 1 0 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 0 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 0 1 1 0 1 1 0 
*	1 0 1 0 0 1 0 0 	1 1 0 0 1 0 0 0 
*	0 0 1 0 1 0 0 0 	1 1 1 0 1 0 0 0 
*	0 0 1 1 0 1 1 0 	1 0 0 1 0 0 0 0 
*	0 0 0 1 0 1 0 1 	0 1 0 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[2];
	assign inL[2] = in[5] ^ in[3];
	assign inL[1] = in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 0 0 1 0 1 0 
	*	0 1 0 1 1 0 0 1 
	*	1 1 0 0 0 0 1 1 
	*	1 0 0 0 0 0 0 1 
	*	1 0 1 0 0 1 0 1 
	*	1 0 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 7 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 0 0 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 1 0 1 0 1 1 0 
*	0 1 1 1 0 1 1 0 	0 1 0 0 1 0 0 0 
*	0 1 0 1 0 1 1 0 	0 1 1 0 1 0 0 0 
*	0 0 1 1 1 0 1 0 	1 0 0 1 0 0 0 0 
*	1 1 0 0 0 1 0 1 	1 0 1 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_7_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 1 0 1 0 1 0 
	*	1 1 0 0 1 0 0 1 
	*	1 1 1 1 0 0 1 1 
	*	1 0 0 1 0 0 0 1 
	*	1 1 1 1 0 1 0 1 
	*	1 0 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 0 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 0 1 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 0 1 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 0 1 0 0 0 1 0 
*	1 1 1 0 1 0 0 0 	0 1 0 0 1 1 0 0 
*	0 0 1 1 1 1 1 0 	1 1 0 0 1 1 0 0 
*	0 1 1 0 1 1 1 0 	0 0 0 1 0 0 0 0 
*	1 0 1 1 1 1 1 1 	1 1 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[3];
	assign inL[2] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 0 0 0 1 0 0 
	*	1 1 1 0 0 0 0 1 
	*	1 0 0 1 0 1 0 1 
	*	0 1 1 1 1 1 0 1 
	*	1 0 0 0 0 1 1 1 
	*	0 0 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 1 1 0 1 1 0 
*	1 1 0 1 1 1 1 0 	1 1 1 0 0 1 0 0 
*	0 1 1 1 0 0 1 0 	0 1 0 1 0 1 1 0 
*	0 0 0 0 0 0 1 0 	1 0 0 0 0 0 1 0 
*	1 1 1 0 0 1 0 0 	1 0 0 0 1 1 0 0 
*	1 1 1 0 0 0 0 0 	0 0 0 0 1 1 0 0 
*	0 0 0 1 1 1 0 0 	0 0 0 1 0 0 0 0 
*	1 0 1 1 1 1 0 1 	1 1 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[0] = in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5];
	assign inL[1] = in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 1 0 1 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 0 0 0 1 0 0 
	*	1 1 1 1 0 0 0 1 
	*	1 1 0 0 0 1 0 1 
	*	1 0 1 0 1 1 0 1 
	*	1 1 1 1 0 1 1 1 
	*	0 1 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 0 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	1 1 0 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 0 1 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	0 0 1 1 1 0 0 0 
*	1 0 1 1 0 0 1 0 	1 0 0 0 0 1 1 0 
*	1 0 0 0 1 0 1 0 	0 1 0 0 0 1 1 0 
*	1 1 1 1 0 0 0 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 1 0 0 1 	1 0 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[1];
	assign inL[2] = in[7] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	1 0 0 1 1 0 1 0 
	*	1 0 1 0 1 1 0 1 
	*	1 1 0 0 0 1 1 1 
	*	1 0 0 1 1 0 1 1 
	*	0 1 1 0 1 1 1 1 
	*	1 0 0 0 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 1 1 0 0 1 0 
*	0 1 1 1 1 1 1 0 	0 1 1 1 1 0 1 0 
*	1 0 1 0 1 1 0 0 	1 0 0 1 0 0 1 0 
*	0 0 0 0 1 1 1 0 	1 0 1 1 1 0 0 0 
*	1 1 0 0 0 0 0 0 	1 1 1 0 0 1 1 0 
*	1 1 1 1 0 1 0 0 	0 0 1 0 0 1 1 0 
*	0 1 0 1 1 1 0 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 0 1 1 1 	1 1 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[0] = in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[1] = in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 0 1 0 0 
	*	1 0 0 1 0 0 0 0 
	*	0 0 1 1 1 0 1 0 
	*	0 1 1 1 1 1 0 1 
	*	1 0 1 1 0 1 1 1 
	*	0 0 1 0 1 0 1 1 
	*	1 0 0 1 1 1 1 1 
	*	1 1 1 1 0 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 0 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 0 1 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	0 1 1 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	0 0 1 0 1 1 0 0 
*	0 0 1 0 1 1 0 0 	0 0 0 0 0 0 1 0 
*	1 1 1 0 1 1 1 0 	0 1 1 0 0 0 1 0 
*	0 0 0 0 1 0 0 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 1 0 1 1 	0 1 1 0 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[3];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 0 0 1 0 1 0 0 
	*	1 0 0 1 1 0 1 1 
	*	0 0 1 1 1 1 1 1 
	*	0 0 0 0 1 0 0 1 
	*	0 0 0 0 0 0 1 1 
	*	1 0 0 1 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outL[3] ^ outL[0];
	assign out[1] = ~( outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 0 0 1 0 0 0 
*	1 1 0 1 1 1 1 0 	0 1 1 1 0 1 0 0 
*	1 1 0 1 0 0 1 0 	1 1 1 0 1 0 0 0 
*	0 1 1 1 1 1 0 0 	1 1 1 0 1 1 0 0 
*	1 0 0 0 0 0 0 0 	0 0 1 0 0 0 1 0 
*	0 0 1 1 0 0 0 0 	0 1 0 0 0 0 1 0 
*	1 1 0 1 1 0 1 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 0 1 1 1 	0 0 0 1 0 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7];
	assign inL[2] = in[5] ^ in[4];
	assign inL[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 1 0 1 0 
	*	0 0 0 1 0 0 0 0 
	*	1 1 0 1 0 1 0 0 
	*	0 0 1 0 1 0 1 1 
	*	1 1 0 0 1 1 1 1 
	*	1 0 0 1 1 0 0 1 
	*	0 0 1 1 0 0 1 1 
	*	0 1 1 0 1 1 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1];
	assign out[6] = ~( outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 0 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 0 1 0 0 1 1 0 
*	1 0 1 0 1 0 1 0 	0 1 1 1 1 0 0 0 
*	1 0 0 0 1 0 0 0 	0 1 0 1 1 0 0 0 
*	0 1 0 0 0 1 1 0 	1 0 0 1 0 0 0 0 
*	1 0 1 1 0 1 1 1 	1 0 0 0 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[3];
	assign inL[1] = in[6] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 0 0 1 0 1 0 
	*	1 0 0 1 1 0 0 1 
	*	0 1 0 0 0 0 1 1 
	*	1 1 1 1 0 0 0 1 
	*	0 0 1 1 0 1 0 1 
	*	0 0 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 2 - 8 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3  + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 0 1 1 1 0 0 
*	1 1 0 1 0 0 0 0 	1 1 0 0 0 1 1 0 
*	0 1 1 1 1 0 0 0 	1 1 1 1 1 0 0 0 
*	1 1 1 1 0 1 1 0 	1 1 0 1 1 0 0 0 
*	0 1 0 0 1 0 1 0 	1 0 0 1 0 0 0 0 
*	0 1 1 0 0 1 1 1 	0 1 1 1 1 1 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_2_8_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[1] = in[3] ^ in[2];
	assign inH[0] = in[7] ^ in[6] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[3] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr2 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul2 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul2 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv2_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul2 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul2 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 0 1 0 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 1 0 1 0 1 0 
	*	0 0 0 0 1 0 0 1 
	*	0 1 1 1 0 0 1 1 
	*	1 1 1 0 0 0 0 1 
	*	0 1 1 0 0 1 0 1 
	*	0 0 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[3] ^ outL[1] );
	assign out[4] = outL[3] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 0 0 0 1 1 0 
*	1 1 0 1 0 1 1 0 	0 0 1 0 1 0 0 0 
*	0 1 0 1 0 0 0 0 	1 0 0 0 1 0 0 0 
*	0 0 1 1 1 1 1 0 	0 1 1 1 0 0 0 0 
*	1 1 0 1 0 0 0 1 	1 1 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[4];
	assign inL[1] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 0 0 0 0 1 0 
	*	1 1 1 0 0 1 1 1 
	*	1 1 0 1 0 1 0 1 
	*	0 0 1 1 1 1 1 1 
	*	1 0 1 0 0 0 1 1 
	*	0 0 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 1 0 0 1 1 0 
*	0 0 0 0 0 1 0 0 	1 0 1 0 1 0 0 0 
*	1 1 1 1 1 1 0 0 	0 0 0 0 1 0 0 0 
*	1 1 1 0 0 0 0 0 	0 1 1 1 0 0 0 0 
*	1 0 1 0 0 0 0 1 	1 1 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5];
	assign inL[0] = in[7] ^ in[5] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 1 0 0 0 1 0 
	*	1 0 0 1 0 1 1 1 
	*	1 0 0 0 0 1 0 1 
	*	1 1 0 0 1 1 1 1 
	*	1 0 0 1 0 0 1 1 
	*	0 1 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 0 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 1 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 0 0 1 1 0 1 0 
*	0 0 1 1 1 0 0 0 	1 0 1 0 0 1 0 0 
*	0 1 1 1 1 0 1 0 	0 0 1 0 0 1 0 0 
*	1 0 0 0 1 0 1 0 	1 1 1 1 0 0 0 0 
*	0 0 0 0 1 0 0 1 	1 0 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[3] ^ in[1];
	assign inL[0] = in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 0 1 1 1 0 0 
	*	1 1 0 0 1 1 1 1 
	*	1 0 0 0 0 0 1 1 
	*	1 1 0 1 1 0 1 1 
	*	0 1 0 0 1 0 0 1 
	*	1 0 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 1 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 0 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 0 1 1 1 0 1 0 
*	0 0 1 1 0 1 0 0 	1 1 1 0 0 1 0 0 
*	1 0 1 0 1 0 0 0 	0 1 1 0 0 1 0 0 
*	1 1 1 1 0 1 0 0 	1 1 1 1 0 0 0 0 
*	1 0 1 0 1 0 1 1 	1 1 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[7] ^ in[5] ^ in[3];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 0 1 1 1 0 0 
	*	0 0 1 1 1 1 1 1 
	*	1 0 1 1 0 0 1 1 
	*	0 1 1 0 1 0 1 1 
	*	1 1 0 1 1 0 0 1 
	*	1 0 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 1 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 1 1 0 1 0 0 0 
*	1 0 1 1 0 0 0 0 	0 1 1 0 0 1 1 0 
*	1 1 1 0 1 0 1 0 	0 0 1 0 0 1 1 0 
*	0 0 1 1 0 0 0 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 1 1 0 1 	0 1 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[1] = in[5] ^ in[4];
	assign inL[0] = in[6] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 1 1 0 0 1 0 
	*	0 1 1 0 1 0 1 1 
	*	1 0 0 0 1 0 0 1 
	*	1 1 0 1 1 1 0 1 
	*	0 0 0 1 0 0 0 1 
	*	0 1 0 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 0 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 1 1 0 1 0 0 0 
*	1 1 0 0 0 0 1 0 	0 0 0 0 0 1 1 0 
*	1 1 1 0 0 1 1 0 	0 1 0 0 0 1 1 0 
*	1 1 1 0 1 1 1 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 0 0 1 1 	0 1 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 0 1 0 0 1 0 
	*	1 1 0 1 1 0 1 1 
	*	0 0 0 1 1 0 0 1 
	*	0 0 0 0 1 1 0 1 
	*	0 0 0 0 0 0 0 1 
	*	1 1 0 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 1 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 1 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 0 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 0 0 0 0 1 0 0 
*	1 0 0 0 1 1 1 0 	1 0 0 1 1 0 1 0 
*	1 0 1 1 1 1 0 0 	1 1 1 1 1 0 1 0 
*	1 1 1 1 0 1 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 1 1 0 1 	0 0 1 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[5] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 1 1 0 1 1 0 0 
	*	0 0 0 0 1 1 0 1 
	*	0 0 1 1 0 0 0 1 
	*	1 1 1 0 0 1 1 1 
	*	0 1 0 0 0 1 0 1 
	*	0 0 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 1 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 2
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 1 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 0 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 0 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 1 0 0 0 1 0 0 
*	0 0 1 0 0 0 1 0 	0 0 1 1 1 0 1 0 
*	1 1 0 0 1 1 1 0 	0 1 0 1 1 0 1 0 
*	1 0 0 0 1 0 0 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 0 0 0 1 	1 0 1 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_1_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[3];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h2));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 0 1 0 1 1 0 0 
	*	1 1 0 1 1 1 0 1 
	*	0 0 1 0 0 0 0 1 
	*	1 0 0 1 0 1 1 1 
	*	0 0 0 1 0 1 0 1 
	*	0 0 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 1 1 0 1 1 0 
*	1 1 0 1 1 0 0 0 	1 1 1 1 1 0 0 0 
*	1 1 1 1 1 1 1 0 	0 1 0 1 1 0 0 0 
*	0 1 0 0 0 0 0 0 	0 1 1 1 0 0 0 0 
*	1 0 1 0 1 1 0 1 	0 1 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[6];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 0 0 0 0 1 0 
	*	1 0 1 0 0 1 1 1 
	*	0 1 0 1 0 1 0 1 
	*	1 0 1 0 1 1 1 1 
	*	1 1 0 1 0 0 1 1 
	*	1 0 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 0 1 0 1 1 0 
*	0 0 0 0 1 0 1 0 	0 1 1 1 1 0 0 0 
*	0 1 0 1 0 0 1 0 	1 1 0 1 1 0 0 0 
*	1 0 0 1 1 1 1 0 	0 1 1 1 0 0 0 0 
*	1 1 0 1 1 1 0 1 	0 1 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 1 0 0 0 1 0 
	*	1 1 0 1 0 1 1 1 
	*	0 0 0 0 0 1 0 1 
	*	0 1 0 1 1 1 1 1 
	*	1 1 1 0 0 0 1 1 
	*	1 1 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 0 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 1 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 0 1 0 1 0 1 0 
*	0 1 0 0 1 0 0 0 	1 1 0 1 0 1 0 0 
*	0 1 1 1 0 1 0 0 	0 1 0 1 0 1 0 0 
*	0 0 1 0 1 0 1 0 	1 1 1 1 0 0 0 0 
*	0 1 1 1 1 0 1 1 	0 1 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[3];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[1] = in[5] ^ in[3] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 1 1 1 1 0 0 
	*	1 0 1 0 1 1 1 1 
	*	1 1 0 0 0 0 1 1 
	*	1 1 0 0 1 0 1 1 
	*	1 0 1 1 1 0 0 1 
	*	1 1 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 1 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 0 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 0 0 0 1 0 1 0 
*	0 1 0 0 0 1 0 0 	1 0 0 1 0 1 0 0 
*	1 0 1 0 0 1 1 0 	0 0 0 1 0 1 0 0 
*	0 1 0 1 0 1 0 0 	1 1 1 1 0 0 0 0 
*	1 1 0 1 1 0 0 1 	0 0 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[2];
	assign inL[2] = in[7] ^ in[5] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[4] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 1 1 1 1 0 0 
	*	0 1 0 1 1 1 1 1 
	*	1 1 1 1 0 0 1 1 
	*	0 1 1 1 1 0 1 1 
	*	0 0 1 0 1 0 0 1 
	*	1 1 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 1 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 0 1 1 1 0 0 0 
*	0 1 1 0 0 0 0 0 	1 0 0 1 0 1 1 0 
*	1 0 0 1 1 0 1 0 	1 1 0 1 0 1 1 0 
*	0 1 0 0 1 1 1 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 1 1 1 1 	0 0 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5];
	assign inL[2] = in[7] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 1 1 0 0 1 0 
	*	1 1 0 0 1 0 1 1 
	*	1 1 1 0 1 0 0 1 
	*	1 0 0 0 1 1 0 1 
	*	1 0 1 0 0 0 0 1 
	*	0 0 1 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 0 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 0 1 1 1 0 0 0 
*	0 0 0 1 0 0 1 0 	1 1 1 1 0 1 1 0 
*	1 0 0 1 0 1 1 0 	1 0 1 1 0 1 1 0 
*	1 0 0 1 0 0 0 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 0 0 0 1 	0 0 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[1];
	assign inL[2] = in[7] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[4];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 0 1 0 0 1 0 
	*	0 1 1 1 1 0 1 1 
	*	0 1 1 1 1 0 0 1 
	*	0 1 0 1 1 1 0 1 
	*	1 0 1 1 0 0 0 1 
	*	1 0 1 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 1 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 0 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 0 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 0 1 1 0 1 0 0 
*	1 0 0 0 1 1 0 0 	1 0 0 0 1 0 1 0 
*	0 0 0 1 1 1 1 0 	1 1 1 0 1 0 1 0 
*	0 0 1 0 1 0 0 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 0 0 1 1 	0 1 0 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[3] ^ in[2];
	assign inL[2] = in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[5] ^ in[3];
	assign inL[0] = in[5] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 0 0 0 1 1 0 0 
	*	0 1 0 1 1 1 0 1 
	*	1 0 0 0 0 0 0 1 
	*	1 0 1 0 0 1 1 1 
	*	1 1 0 0 0 1 0 1 
	*	1 0 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 2 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 3
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 1 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 1 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 0 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 1 1 1 0 1 0 0 
*	0 0 1 0 0 0 0 0 	0 0 1 0 1 0 1 0 
*	0 1 1 0 1 1 0 0 	0 1 0 0 1 0 1 0 
*	0 1 0 1 0 1 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 1 1 1 1 	1 1 0 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_2_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5];
	assign inL[2] = in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[1] = in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h3));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 1 0 0 1 1 0 0 
	*	1 0 0 0 1 1 0 1 
	*	1 0 0 1 0 0 0 1 
	*	1 1 0 1 0 1 1 1 
	*	1 0 0 1 0 1 0 1 
	*	1 0 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 1 1 0 1 1 0 
*	1 0 1 0 1 0 0 0 	1 1 1 0 1 0 0 0 
*	0 1 0 1 1 1 0 0 	0 1 0 0 1 0 0 0 
*	1 0 0 1 1 1 0 0 	0 1 1 1 0 0 0 0 
*	0 0 0 0 0 0 1 1 	0 1 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[3];
	assign inL[2] = in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 0 1 0 0 1 0 
	*	0 1 0 1 0 1 1 1 
	*	1 1 1 1 0 1 0 1 
	*	0 1 0 0 1 1 1 1 
	*	1 0 1 1 0 0 1 1 
	*	0 0 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 0 1 0 1 1 0 
*	0 1 1 1 1 0 1 0 	0 1 1 0 1 0 0 0 
*	1 1 1 1 0 0 0 0 	1 1 0 0 1 0 0 0 
*	0 1 0 0 0 0 1 0 	0 1 1 1 0 0 0 0 
*	0 1 1 1 0 0 1 1 	0 1 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4];
	assign inL[1] = in[6] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 1 1 0 0 1 0 
	*	0 0 1 0 0 1 1 1 
	*	1 0 1 0 0 1 0 1 
	*	1 0 1 1 1 1 1 1 
	*	1 0 0 0 0 0 1 1 
	*	0 1 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 0 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 1 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 1 1 0 1 0 1 0 
*	1 1 1 0 1 0 1 0 	0 1 0 0 0 1 0 0 
*	1 1 0 1 1 0 1 0 	1 1 0 0 0 1 0 0 
*	0 1 0 1 1 0 1 0 	1 1 1 1 0 0 0 0 
*	1 0 1 0 0 1 1 1 	1 1 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 1 1 1 1 0 0 
	*	0 1 0 0 1 1 1 1 
	*	1 0 1 0 0 0 1 1 
	*	1 0 1 1 1 0 1 1 
	*	1 0 0 1 1 0 0 1 
	*	1 0 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 1 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 0 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 1 0 0 1 0 1 0 
*	1 1 1 0 0 1 1 0 	0 0 0 0 0 1 0 0 
*	0 0 0 0 1 0 0 0 	1 0 0 0 0 1 0 0 
*	0 0 1 0 0 1 0 0 	1 1 1 1 0 0 0 0 
*	0 0 0 0 0 1 0 1 	1 0 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[3];
	assign inL[1] = in[5] ^ in[2];
	assign inL[0] = in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 1 1 1 1 0 0 
	*	1 0 1 1 1 1 1 1 
	*	1 0 0 1 0 0 1 1 
	*	0 0 0 0 1 0 1 1 
	*	0 0 0 0 1 0 0 1 
	*	1 0 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 1 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 0 1 0 1 0 0 0 
*	1 1 0 0 1 1 1 0 	0 1 0 1 0 1 1 0 
*	0 1 0 0 0 1 1 0 	0 0 0 1 0 1 1 0 
*	1 1 1 0 1 1 0 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 1 1 1 1 	0 1 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[0] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 1 0 0 0 1 0 
	*	1 0 1 1 1 0 1 1 
	*	1 1 0 0 1 0 0 1 
	*	0 0 1 1 1 1 0 1 
	*	1 0 0 1 0 0 0 1 
	*	0 0 0 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[3] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 0 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 0 1 0 1 0 0 0 
*	1 0 1 1 1 1 0 0 	0 0 1 1 0 1 1 0 
*	0 1 0 0 1 0 1 0 	0 1 1 1 0 1 1 0 
*	0 0 1 1 0 0 1 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 0 0 0 1 	0 1 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[6] ^ in[3] ^ in[1];
	assign inL[1] = in[5] ^ in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 0 0 0 0 1 0 
	*	0 0 0 0 1 0 1 1 
	*	0 1 0 1 1 0 0 1 
	*	1 1 1 0 1 1 0 1 
	*	1 0 0 0 0 0 0 1 
	*	1 0 0 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[1] );
	assign out[4] = outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 1 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 0 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 0 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 0 1 0 0 1 0 0 
*	0 1 0 1 0 0 0 0 	1 1 0 0 1 0 1 0 
*	0 1 1 0 1 1 1 0 	1 0 1 0 1 0 1 0 
*	1 0 0 0 0 1 1 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 0 0 0 1 	0 1 1 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4];
	assign inL[2] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 0 0 0 1 1 0 0 
	*	1 1 1 0 1 1 0 1 
	*	1 0 1 1 0 0 0 1 
	*	0 1 0 1 0 1 1 1 
	*	0 1 1 0 0 1 0 1 
	*	1 0 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 3 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 4
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 1 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 1 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 0 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 1 1 0 0 1 0 0 
*	1 1 1 1 1 1 0 0 	0 1 1 0 1 0 1 0 
*	0 0 0 1 1 1 0 0 	0 0 0 0 1 0 1 0 
*	1 1 1 1 1 0 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 1 1 0 1 	1 1 1 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_3_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[4] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[0] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h4));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 1 0 0 1 1 0 0 
	*	0 0 1 1 1 1 0 1 
	*	1 0 1 0 0 0 0 1 
	*	0 0 1 0 0 1 1 1 
	*	0 0 1 1 0 1 0 1 
	*	1 0 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[0];
	assign out[2] = outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 0 0 0 1 1 0 
*	1 0 1 0 0 1 1 0 	0 0 1 1 1 0 0 0 
*	1 1 1 1 0 0 1 0 	1 0 0 1 1 0 0 0 
*	1 1 1 0 0 0 1 0 	0 1 1 1 0 0 0 0 
*	0 1 1 1 1 1 1 1 	1 1 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 0 1 0 0 1 0 
	*	0 0 0 1 0 1 1 1 
	*	0 1 1 1 0 1 0 1 
	*	1 1 0 1 1 1 1 1 
	*	1 1 0 0 0 0 1 1 
	*	1 0 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 1 0 0 1 1 0 
*	0 1 1 1 0 1 0 0 	1 0 1 1 1 0 0 0 
*	0 1 0 1 1 1 1 0 	0 0 0 1 1 0 0 0 
*	0 0 1 1 1 1 0 0 	0 1 1 1 0 0 0 0 
*	0 0 0 0 1 1 1 1 	1 1 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[2] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 1 1 0 0 1 0 
	*	0 1 1 0 0 1 1 1 
	*	0 0 1 0 0 1 0 1 
	*	0 0 1 0 1 1 1 1 
	*	1 1 1 1 0 0 1 1 
	*	1 1 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 0 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 1 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 1 0 1 1 0 1 0 
*	1 0 0 1 1 0 1 0 	0 0 1 1 0 1 0 0 
*	1 1 0 1 0 1 0 0 	1 0 1 1 0 1 0 0 
*	1 1 1 1 1 0 1 0 	1 1 1 1 0 0 0 0 
*	1 1 0 1 0 1 0 1 	0 0 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 0 1 1 1 0 0 
	*	0 0 1 0 1 1 1 1 
	*	1 1 1 0 0 0 1 1 
	*	1 0 1 0 1 0 1 1 
	*	0 1 1 0 1 0 0 1 
	*	1 1 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 1 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 0 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 1 1 1 1 0 1 0 
*	1 0 0 1 0 1 1 0 	0 1 1 1 0 1 0 0 
*	0 0 0 0 0 1 1 0 	1 1 1 1 0 1 0 0 
*	1 0 0 0 0 1 0 0 	1 1 1 1 0 0 0 0 
*	0 1 1 1 0 1 1 1 	0 1 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[2];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 0 1 1 1 0 0 
	*	1 1 0 1 1 1 1 1 
	*	1 1 0 1 0 0 1 1 
	*	0 0 0 1 1 0 1 1 
	*	1 1 1 1 1 0 0 1 
	*	1 1 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 1 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 1 1 1 1 0 0 0 
*	0 0 0 1 1 1 1 0 	1 0 1 0 0 1 1 0 
*	0 0 1 1 0 1 1 0 	1 1 1 0 0 1 1 0 
*	1 0 0 1 0 0 1 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 1 1 0 1 	0 0 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[4] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 1 0 0 0 1 0 
	*	0 0 0 1 1 0 1 1 
	*	1 0 1 0 1 0 0 1 
	*	0 1 1 0 1 1 0 1 
	*	0 0 1 0 0 0 0 1 
	*	0 1 1 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[1] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 0 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 1 1 1 1 0 0 0 
*	0 1 1 0 1 1 0 0 	1 1 0 0 0 1 1 0 
*	0 0 1 1 1 0 1 0 	1 0 0 0 0 1 1 0 
*	0 1 0 0 1 1 0 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 0 0 1 1 	0 0 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[2] = in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 0 0 0 0 1 0 
	*	1 0 1 0 1 0 1 1 
	*	0 0 1 1 1 0 0 1 
	*	1 0 1 1 1 1 0 1 
	*	0 0 1 1 0 0 0 1 
	*	1 1 1 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 1 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 1 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 0 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 0 0 1 0 1 0 0 
*	0 1 0 1 0 0 1 0 	1 1 0 1 1 0 1 0 
*	1 1 0 0 1 1 0 0 	1 0 1 1 1 0 1 0 
*	0 1 0 1 1 0 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 1 1 1 1 	0 0 0 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[3] ^ in[2];
	assign inL[1] = in[6] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 1 1 0 1 1 0 0 
	*	1 0 1 1 1 1 0 1 
	*	0 0 0 0 0 0 0 1 
	*	0 0 0 1 0 1 1 1 
	*	1 1 1 0 0 1 0 1 
	*	0 0 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outL[0];
	assign out[2] = outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 4 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 5
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 1 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 0 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 0 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 1 0 1 0 1 0 0 
*	1 1 1 1 1 1 1 0 	0 1 1 1 1 0 1 0 
*	1 0 1 1 1 1 1 0 	0 0 0 1 1 0 1 0 
*	0 0 1 0 0 1 1 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 0 0 1 1 	1 0 0 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_4_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[5] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h5));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 0 1 0 1 1 0 0 
	*	0 1 1 0 1 1 0 1 
	*	0 0 0 1 0 0 0 1 
	*	0 1 1 0 0 1 1 1 
	*	1 0 1 1 0 1 0 1 
	*	0 0 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[0] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 1 0 0 1 1 0 
*	1 0 1 0 1 0 1 0 	1 0 0 1 1 0 0 0 
*	0 0 1 0 0 0 1 0 	0 0 1 1 1 0 0 0 
*	1 1 1 0 1 1 0 0 	0 1 1 1 0 0 0 0 
*	1 1 0 1 0 0 1 1 	1 0 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[3] ^ in[1];
	assign inL[2] = in[5] ^ in[1];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 0 0 0 0 1 0 
	*	0 1 1 1 0 1 1 1 
	*	1 1 0 0 0 1 0 1 
	*	0 0 0 1 1 1 1 1 
	*	0 1 0 1 0 0 1 1 
	*	0 0 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[2] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 0 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 1 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 1 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 0 0 0 1 1 0 
*	0 1 1 1 1 0 0 0 	0 0 0 1 1 0 0 0 
*	1 0 0 0 1 1 1 0 	1 0 1 1 1 0 0 0 
*	0 0 1 1 0 0 1 0 	0 1 1 1 0 0 0 0 
*	1 0 1 0 0 0 1 1 	1 0 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[5] ^ in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 0 1 0 0 0 1 0 
	*	0 0 0 0 0 1 1 1 
	*	1 0 0 1 0 1 0 1 
	*	1 1 1 0 1 1 1 1 
	*	0 1 1 0 0 0 1 1 
	*	0 1 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[1] );
	assign out[4] = outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 0 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 1 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 0 0 0 1 0 1 0 
*	1 1 1 0 0 1 0 0 	1 0 0 0 0 1 0 0 
*	0 0 0 0 0 1 0 0 	0 0 0 0 0 1 0 0 
*	1 1 1 1 1 0 0 0 	1 1 1 1 0 0 0 0 
*	1 0 1 0 0 1 0 1 	1 1 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[2];
	assign inL[2] = in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[5] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 0 0 1 1 0 0 
	*	0 0 0 1 1 1 1 1 
	*	0 1 0 0 0 0 1 1 
	*	0 0 1 0 1 0 1 1 
	*	0 0 0 1 1 0 0 1 
	*	0 1 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 1 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 0 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 0 1 0 1 0 1 0 
*	1 1 1 0 1 0 0 0 	1 1 0 0 0 1 0 0 
*	1 1 0 1 0 1 1 0 	0 1 0 0 0 1 0 0 
*	1 0 0 0 0 1 1 0 	1 1 1 1 0 0 0 0 
*	0 0 0 0 0 1 1 1 	1 0 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[7] ^ in[2] ^ in[1];
	assign inL[0] = in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 0 0 1 1 0 0 
	*	1 1 1 0 1 1 1 1 
	*	0 1 1 1 0 0 1 1 
	*	1 0 0 1 1 0 1 1 
	*	1 0 0 0 1 0 0 1 
	*	0 1 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 1 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 1 0 1 1 0 0 0 
*	1 1 0 0 0 0 0 0 	1 1 1 0 0 1 1 0 
*	0 0 1 1 0 1 0 0 	1 0 1 0 0 1 1 0 
*	1 0 0 1 1 1 0 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 1 1 1 1 	1 0 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6];
	assign inL[2] = in[5] ^ in[4] ^ in[2];
	assign inL[1] = in[7] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 0 1 0 0 1 0 
	*	1 0 0 1 1 0 1 1 
	*	1 1 0 1 1 0 0 1 
	*	1 0 1 0 1 1 0 1 
	*	0 1 1 1 0 0 0 1 
	*	0 0 0 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 0 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 0 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 1 0 1 1 0 0 0 
*	1 0 1 1 0 0 1 0 	1 0 0 0 0 1 1 0 
*	0 0 1 1 1 0 0 0 	1 1 0 0 0 1 1 0 
*	0 1 0 0 0 0 1 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 0 0 0 1 	1 0 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[1];
	assign inL[2] = in[5] ^ in[4] ^ in[3];
	assign inL[1] = in[6] ^ in[1];
	assign inL[0] = in[5] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 1 1 1 0 0 1 0 
	*	0 0 1 0 1 0 1 1 
	*	0 1 0 0 1 0 0 1 
	*	0 1 1 1 1 1 0 1 
	*	0 1 1 0 0 0 0 1 
	*	1 0 0 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outL[3] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 0 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 1 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 1 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 0 1 0 0 1 0 0 
*	0 0 1 0 1 1 0 0 	0 0 0 0 1 0 1 0 
*	1 1 0 0 0 0 1 0 	0 1 1 0 1 0 1 0 
*	0 0 1 0 0 1 0 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 0 0 0 1 	0 1 1 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[1];
	assign inL[1] = in[5] ^ in[2];
	assign inL[0] = in[5] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 1 1 1 1 1 0 0 
	*	0 1 1 1 1 1 0 1 
	*	0 1 0 1 0 0 0 1 
	*	0 0 0 0 0 1 1 1 
	*	0 0 0 0 0 1 0 1 
	*	0 1 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[0];
	assign out[2] = outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 5 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 8
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 0 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 0 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 1 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 1 1 0 0 1 0 0 
*	1 0 0 0 0 0 0 0 	1 0 1 0 1 0 1 0 
*	1 0 1 1 0 0 0 0 	1 1 0 0 1 0 1 0 
*	0 1 0 1 1 0 1 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 1 1 0 1 	1 1 1 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_5_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7];
	assign inL[2] = in[7] ^ in[5] ^ in[4];
	assign inL[1] = in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h8));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 0 1 1 1 1 0 0 
	*	1 0 1 0 1 1 0 1 
	*	0 1 0 0 0 0 0 1 
	*	0 1 1 1 0 1 1 1 
	*	0 1 0 1 0 1 0 1 
	*	0 1 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 0 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 0 1 0 1 1 0 
*	1 0 1 0 0 1 0 0 	0 1 0 0 1 0 0 0 
*	1 0 0 0 1 1 0 0 	1 1 1 0 1 0 0 0 
*	1 0 0 1 0 0 1 0 	0 1 1 1 0 0 0 0 
*	1 0 1 0 1 1 1 1 	0 0 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[5] ^ in[2];
	assign inL[2] = in[7] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[4] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 0 0 0 0 1 0 
	*	0 0 1 1 0 1 1 1 
	*	0 1 0 0 0 1 0 1 
	*	1 0 0 0 1 1 1 1 
	*	0 0 1 0 0 0 1 1 
	*	1 0 0 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	1 1 1 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 0 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 0 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 1 1 0 1 1 0 
*	0 1 1 1 0 1 1 0 	1 1 0 0 1 0 0 0 
*	0 0 1 0 0 0 0 0 	0 1 1 0 1 0 0 0 
*	0 1 0 0 1 1 0 0 	0 1 1 1 0 0 0 0 
*	1 1 0 1 1 1 1 1 	0 0 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[5];
	assign inL[1] = in[6] ^ in[3] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 1 1 0 0 0 1 0 
	*	0 1 0 0 0 1 1 1 
	*	0 0 0 1 0 1 0 1 
	*	0 1 1 1 1 1 1 1 
	*	0 0 0 1 0 0 1 1 
	*	1 1 0 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 0 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 1 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 1 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 0 1 1 1 0 1 0 
*	1 0 0 1 0 1 0 0 	1 1 1 1 0 1 0 0 
*	0 0 0 0 1 0 1 0 	0 1 1 1 0 1 0 0 
*	0 1 0 1 1 0 0 0 	1 1 1 1 0 0 0 0 
*	1 1 0 1 0 1 1 1 	0 0 1 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[2];
	assign inL[2] = in[3] ^ in[1];
	assign inL[1] = in[6] ^ in[4] ^ in[3];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 1 1 0 1 1 0 0 
	*	0 1 1 1 1 1 1 1 
	*	0 0 0 0 0 0 1 1 
	*	0 0 1 1 1 0 1 1 
	*	1 1 1 0 1 0 0 1 
	*	0 0 1 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outL[1] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 1 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 0 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 0 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 0 0 1 1 0 1 0 
*	1 0 0 1 1 0 0 0 	1 0 1 1 0 1 0 0 
*	1 1 0 1 1 0 0 0 	0 0 1 1 0 1 0 0 
*	0 0 1 0 0 1 1 0 	1 1 1 1 0 0 0 0 
*	0 1 1 1 0 1 0 1 	0 1 1 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[7] ^ in[4] ^ in[3];
	assign inL[2] = in[7] ^ in[6] ^ in[4] ^ in[3];
	assign inL[1] = in[5] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 0 1 0 1 1 0 0 
	*	1 0 0 0 1 1 1 1 
	*	0 0 1 1 0 0 1 1 
	*	1 0 0 0 1 0 1 1 
	*	0 1 1 1 1 0 0 1 
	*	0 0 0 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 0 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 1 1 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 0 0 0 1 0 0 0 
*	0 0 0 1 0 0 0 0 	0 0 0 1 0 1 1 0 
*	0 1 0 0 0 1 0 0 	0 1 0 1 0 1 1 0 
*	1 1 1 0 0 0 1 0 	1 0 1 1 0 0 0 0 
*	1 0 0 1 1 1 0 1 	1 1 0 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4];
	assign inL[2] = in[6] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[1];
	assign inL[0] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 0 1 0 0 1 0 
	*	0 0 1 1 1 0 1 1 
	*	1 0 1 1 1 0 0 1 
	*	1 1 1 1 1 1 0 1 
	*	1 1 0 0 0 0 0 1 
	*	0 1 1 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 0 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 1 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 0 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 0 0 0 1 0 0 0 
*	0 1 1 0 0 0 1 0 	0 1 1 1 0 1 1 0 
*	0 1 0 0 1 0 0 0 	0 0 1 1 0 1 1 0 
*	0 0 1 1 1 1 0 0 	1 0 1 1 0 0 0 0 
*	0 0 1 1 0 0 1 1 	1 1 1 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[1];
	assign inL[2] = in[6] ^ in[3];
	assign inL[1] = in[5] ^ in[4] ^ in[3] ^ in[2];
	assign inL[0] = in[5] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 0 1 1 0 0 1 0 
	*	1 0 0 0 1 0 1 1 
	*	0 0 1 0 1 0 0 1 
	*	0 0 1 0 1 1 0 1 
	*	1 1 0 1 0 0 0 1 
	*	1 1 1 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outL[3] ^ outL[0];
	assign out[2] = outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 0 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 0 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 1 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 0 0 1 0 1 0 0 
*	0 0 1 0 1 1 1 0 	0 0 0 1 1 0 1 0 
*	0 1 1 0 0 0 0 0 	0 1 1 1 1 0 1 0 
*	1 1 1 1 1 0 1 0 	1 1 0 1 0 0 0 0 
*	0 0 1 0 1 1 1 1 	0 0 0 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[5];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[0] = in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 0 0 1 1 1 0 0 
	*	0 0 1 0 1 1 0 1 
	*	1 1 1 0 0 0 0 1 
	*	0 1 0 0 0 1 1 1 
	*	1 0 0 0 0 1 0 1 
	*	1 1 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[1] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[0];
	assign out[2] = outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 6 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + 9
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 0 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 1 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 1 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	1 1 0 1 0 1 0 0 
*	1 0 0 0 0 0 1 0 	1 0 1 1 1 0 1 0 
*	0 0 0 1 0 0 1 0 	1 1 0 1 1 0 1 0 
*	1 0 0 0 0 1 0 0 	1 1 0 1 0 0 0 0 
*	1 1 1 1 0 0 1 1 	1 0 0 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_6_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[1];
	assign inL[2] = in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[2];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'h9));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 1 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 1 0 1 1 1 0 0 
	*	1 1 1 1 1 1 0 1 
	*	1 1 1 1 0 0 0 1 
	*	0 0 1 1 0 1 1 1 
	*	1 1 0 1 0 1 0 1 
	*	1 1 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 0 0 1 0 1 1 0 
*	1 1 0 1 0 1 0 0 	0 1 0 1 1 0 0 0 
*	0 0 1 0 1 1 1 0 	1 1 1 1 1 0 0 0 
*	0 1 0 0 1 1 1 0 	0 1 1 1 0 0 0 0 
*	0 0 0 0 0 0 0 1 	0 0 0 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[2];
	assign inL[2] = in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 0 1 0 0 1 0 
	*	1 1 0 0 0 1 1 1 
	*	1 1 1 0 0 1 0 1 
	*	0 1 1 0 1 1 1 1 
	*	0 1 0 0 0 0 1 1 
	*	0 0 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 1 1 0 1 0 0 
*	1 0 1 0 1 1 0 0 	1 1 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 0 1 0 1 0 0 
*	0 1 1 1 0 0 0 0 	0 1 1 1 0 1 1 0 
*	0 0 0 0 0 1 1 0 	1 1 0 1 1 0 0 0 
*	1 0 0 0 0 0 1 0 	0 1 1 1 1 0 0 0 
*	1 0 0 1 0 0 0 0 	0 1 1 1 0 0 0 0 
*	0 1 1 1 0 0 0 1 	0 0 0 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[1];
	assign inL[1] = in[7] ^ in[4];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	0 0 1 1 0 0 1 0 
	*	1 0 1 1 0 1 1 1 
	*	1 0 1 1 0 1 0 1 
	*	1 0 0 1 1 1 1 1 
	*	0 1 1 1 0 0 1 1 
	*	0 1 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 0 0 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 1 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 1 1 1 1 0 1 0 
*	0 0 1 1 0 1 1 0 	0 1 1 0 0 1 0 0 
*	1 0 1 0 0 1 0 0 	1 1 1 0 0 1 0 0 
*	0 0 1 0 1 0 0 0 	1 1 1 1 0 0 0 0 
*	0 0 0 0 1 0 1 1 	1 0 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[2];
	assign inL[1] = in[5] ^ in[3];
	assign inL[0] = in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 1 0 1 1 0 0 
	*	1 0 0 1 1 1 1 1 
	*	0 1 1 0 0 0 1 1 
	*	0 1 0 0 1 0 1 1 
	*	1 1 0 0 1 0 0 1 
	*	0 1 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	1 1 1 0 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 0 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 0 0 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 1 0 1 1 0 1 0 
*	0 0 1 1 1 0 1 0 	0 0 1 0 0 1 0 0 
*	0 1 1 1 0 1 1 0 	1 0 1 0 0 1 0 0 
*	0 1 0 1 0 1 1 0 	1 1 1 1 0 0 0 0 
*	1 0 1 0 1 0 0 1 	1 1 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[5] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[1] = in[6] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[5] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 1 0 1 1 0 0 
	*	0 1 1 0 1 1 1 1 
	*	0 1 0 1 0 0 1 1 
	*	1 1 1 1 1 0 1 1 
	*	0 1 0 1 1 0 0 1 
	*	0 1 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outH[1] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 0 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 1 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 0 0 1 1 0 0 0 
*	1 0 1 1 1 1 1 0 	1 1 0 1 0 1 1 0 
*	1 0 0 1 1 0 0 0 	1 0 0 1 0 1 1 0 
*	0 1 0 0 0 0 0 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 1 1 0 1 	1 0 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[4] ^ in[3];
	assign inL[1] = in[6];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 1 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 0 0 0 0 1 0 
	*	0 1 0 0 1 0 1 1 
	*	1 0 0 1 1 0 0 1 
	*	0 1 0 0 1 1 0 1 
	*	1 1 1 1 0 0 0 1 
	*	0 1 0 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outL[1] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 1 0 1 0 1 0 
*	0 0 0 0 1 1 0 0 	0 0 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 0 0 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 0 0 1 1 0 0 0 
*	1 1 0 0 1 1 0 0 	1 0 1 1 0 1 1 0 
*	1 0 0 1 0 1 0 0 	1 1 1 1 0 1 1 0 
*	1 0 0 1 1 1 1 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 0 0 1 1 	1 0 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[7] ^ in[6] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[4] ^ in[2];
	assign inL[1] = in[7] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[6] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 1 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	1 1 1 0 0 0 1 0 
	*	1 1 1 1 1 0 1 1 
	*	0 0 0 0 1 0 0 1 
	*	1 0 0 1 1 1 0 1 
	*	1 1 1 0 0 0 0 1 
	*	1 1 0 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 1 0 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 0 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 1 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 0 0 0 0 1 0 0 
*	1 1 1 1 0 0 1 0 	0 1 0 1 1 0 1 0 
*	0 0 0 1 0 0 0 0 	0 0 1 1 1 0 1 0 
*	0 1 0 1 0 1 0 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 1 1 0 1 	0 0 1 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inL[2] = in[4];
	assign inL[1] = in[6] ^ in[4] ^ in[2];
	assign inL[0] = in[7] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 0 0 1 1 1 0 0 
	*	1 0 0 1 1 1 0 1 
	*	1 1 0 1 0 0 0 1 
	*	1 0 1 1 0 1 1 1 
	*	0 0 1 0 0 1 0 1 
	*	1 1 1 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 7 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + E
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 1 0 0 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 1 1 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 0 1 0 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 1 0 0 0 1 0 0 
*	0 1 0 1 1 1 1 0 	1 1 1 1 1 0 1 0 
*	0 1 1 0 0 0 1 0 	1 0 0 1 1 0 1 0 
*	0 0 1 0 1 0 1 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 0 0 0 1 	1 0 1 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_7_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[6] ^ in[5] ^ in[1];
	assign inL[1] = in[5] ^ in[3] ^ in[1];
	assign inL[0] = in[6] ^ in[4] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hE));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 1 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 1 0 1 1 1 0 0 
	*	0 1 0 0 1 1 0 1 
	*	1 1 0 0 0 0 0 1 
	*	1 1 0 0 0 1 1 1 
	*	0 1 1 1 0 1 0 1 
	*	1 1 1 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 1
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 0 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 0 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 1 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 1 1 0 0 1 1 0 
*	1 1 0 1 1 0 1 0 	1 0 0 0 1 0 0 0 
*	1 0 0 0 0 0 0 0 	0 0 1 0 1 0 0 0 
*	0 0 1 1 0 0 0 0 	0 1 1 1 0 0 0 0 
*	0 1 1 1 1 1 0 1 	1 0 1 1 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_1 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1];
	assign inL[2] = in[7];
	assign inL[1] = in[5] ^ in[4];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 0 0 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 0 1 0 0 1 0 
	*	1 0 0 0 0 1 1 1 
	*	0 1 1 0 0 1 0 1 
	*	1 1 1 1 1 1 1 1 
	*	0 0 1 1 0 0 1 1 
	*	1 0 1 0 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[2] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 2
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 1 0 1 0 0 1 0 	0 1 0 0 0 1 0 0 
*	1 0 1 0 1 1 0 0 	0 0 1 1 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 1 0 0 1 0 0 
*	0 1 1 1 0 0 0 0 	1 0 0 0 0 1 1 0 
*	0 0 0 0 1 0 0 0 	0 0 0 0 1 0 0 0 
*	0 0 1 0 1 1 0 0 	1 0 1 0 1 0 0 0 
*	1 1 1 0 1 1 1 0 	0 1 1 1 0 0 0 0 
*	0 0 0 0 1 1 0 1 	1 0 1 0 0 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_2 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[2] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[6] ^ in[5] ^ in[4];
	assign inL[3] = in[3];
	assign inL[2] = in[5] ^ in[3] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[3] ^ in[2] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 1 1 0 0 
	*	1 0 1 1 0 0 0 0 
	*	1 1 1 1 0 0 1 0 
	*	1 1 1 1 0 1 1 1 
	*	0 0 1 1 0 1 0 1 
	*	0 0 0 0 1 1 1 1 
	*	0 0 0 0 0 0 1 1 
	*	1 1 1 1 0 1 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[3] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outH[0] ^ outL[2] ^ outL[0];
	assign out[2] = outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outL[1] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 3
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 0 0 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	0 1 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 1 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	1 1 0 0 1 0 1 0 
*	0 1 0 0 0 1 1 0 	0 0 0 1 0 1 0 0 
*	1 0 1 0 1 0 1 0 	1 0 0 1 0 1 0 0 
*	1 0 0 0 1 0 0 0 	1 1 1 1 0 0 0 0 
*	0 1 1 1 1 0 0 1 	0 1 0 0 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_3 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[5] ^ in[3] ^ in[1];
	assign inL[1] = in[7] ^ in[3];
	assign inL[0] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	0 1 0 0 1 1 0 0 
	*	1 1 1 1 1 1 1 1 
	*	0 0 1 0 0 0 1 1 
	*	0 1 0 1 1 0 1 1 
	*	0 0 1 1 1 0 0 1 
	*	0 0 0 0 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[2] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[1] ^ outL[1] ^ outL[0];
	assign out[2] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 4
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 0 0 0 1 1 0 0 	0 1 1 1 0 1 1 0 
*	1 1 0 1 0 0 1 0 	1 0 1 0 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 0 0 1 0 1 1 0 
*	1 0 1 0 0 0 1 0 	0 1 1 0 1 0 1 0 
*	0 1 0 0 1 0 1 0 	0 1 0 1 0 1 0 0 
*	0 1 1 1 1 0 0 0 	1 1 0 1 0 1 0 0 
*	1 1 1 1 0 1 1 0 	1 1 1 1 0 0 0 0 
*	1 1 0 1 1 0 1 1 	0 0 0 1 0 1 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_4 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[3] ^ in[2];
	assign inH[2] = in[7] ^ in[6] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[1];
	assign inL[3] = in[6] ^ in[3] ^ in[1];
	assign inL[2] = in[6] ^ in[5] ^ in[4] ^ in[3];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 1 0 0 1 0 
	*	1 1 0 1 0 0 0 0 
	*	1 0 0 0 1 1 0 0 
	*	0 0 0 0 1 1 1 1 
	*	0 0 0 1 0 0 1 1 
	*	1 1 1 0 1 0 1 1 
	*	1 0 1 0 1 0 0 1 
	*	0 0 1 1 0 0 1 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outH[0] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outL[3] ^ outL[2] );
	assign out[4] = outL[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[3] = outH[0] ^ outL[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[1] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 5
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	1 1 0 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 0 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	0 0 1 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	1 1 0 0 1 0 0 0 
*	0 1 1 0 1 1 1 0 	0 0 1 0 0 1 1 0 
*	1 1 1 0 1 0 0 0 	0 1 1 0 0 1 1 0 
*	0 0 1 1 1 1 1 0 	1 0 1 1 0 0 0 0 
*	1 1 1 0 1 1 1 1 	1 1 0 1 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_5 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[3];
	assign inL[1] = in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inL[0] = in[7] ^ in[6] ^ in[5] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	1 1 0 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 0 0 0 0 1 0 
	*	1 1 1 0 1 0 1 1 
	*	1 1 1 1 1 0 0 1 
	*	0 0 0 1 1 1 0 1 
	*	0 1 0 0 0 0 0 1 
	*	0 0 1 1 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outL[1] );
	assign out[4] = outH[3] ^ outH[2] ^ outH[1] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[0];
	assign out[2] = outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outL[0] );
	assign out[0] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 6
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	0 1 1 1 0 0 1 0 	0 1 1 1 1 0 1 0 
*	0 0 0 0 1 1 0 0 	1 1 1 0 0 0 1 0 
*	1 1 0 1 1 1 1 0 	1 0 0 1 1 0 1 0 
*	1 0 1 0 1 1 1 0 	0 1 0 0 1 0 0 0 
*	0 0 0 1 1 1 0 0 	0 1 0 0 0 1 1 0 
*	1 1 1 0 0 1 0 0 	0 0 0 0 0 1 1 0 
*	1 1 1 0 0 0 0 0 	1 0 1 1 0 0 0 0 
*	0 1 0 0 0 0 0 1 	1 1 1 0 0 0 1 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_6 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[2] = in[3] ^ in[2];
	assign inH[1] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[5] ^ in[3] ^ in[2] ^ in[1];
	assign inL[3] = in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[6] ^ in[5] ^ in[2];
	assign inL[1] = in[7] ^ in[6] ^ in[5];
	assign inL[0] = in[6] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 0 0 0 1 1 0 0 
	*	0 1 1 1 0 0 0 0 
	*	0 0 1 0 0 0 1 0 
	*	0 1 0 1 1 0 1 1 
	*	0 1 1 0 1 0 0 1 
	*	1 1 0 0 1 1 0 1 
	*	0 1 0 1 0 0 0 1 
	*	1 0 1 0 1 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outL[3] ^ outL[2];
	assign out[6] = ~( outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outL[1] );
	assign out[4] = outH[2] ^ outH[0] ^ outL[3] ^ outL[1] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[3] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[1] = ~( outH[2] ^ outH[0] ^ outL[0] );
	assign out[0] = ~( outH[3] ^ outH[1] ^ outL[3] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 7
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	1 0 0 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	1 1 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	0 1 1 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 0 1 1 0 1 0 0 
*	1 1 1 1 0 0 0 0 	0 1 0 0 1 0 1 0 
*	1 0 1 1 0 0 1 0 	0 0 1 0 1 0 1 0 
*	1 0 0 0 1 0 1 0 	1 1 0 1 0 0 0 0 
*	1 0 0 0 0 0 1 1 	0 1 0 0 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_7 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[7] ^ in[6] ^ in[5] ^ in[4];
	assign inL[2] = in[7] ^ in[5] ^ in[4] ^ in[1];
	assign inL[1] = in[7] ^ in[3] ^ in[1];
	assign inL[0] = in[7] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 0 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	1 1 1 1 1 1 0 0 
	*	1 1 0 0 1 1 0 1 
	*	0 1 1 0 0 0 0 1 
	*	1 1 1 1 0 1 1 1 
	*	1 0 1 0 0 1 0 1 
	*	0 1 0 0 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[3] ^ outH[2] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outL[0];
	assign out[2] = outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[1] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outL[0] );

endmodule





/*****************************************************
* S-Box # 3 - 8 - 8
*
* GF(2^8): x^8 + x^4 + x^3 + x + 1
* GF(2^4): x^4 + x^3 + x^2 + x + 1
* GF((2^4)^2): x^2 + x + F
*
* Mapping & Inverse Mapping:
*
*	1 0 1 0 1 1 0 0 	0 0 0 1 1 0 0 0 
*	0 1 1 1 0 0 1 0 	0 0 0 1 1 1 0 0 
*	0 1 1 1 1 1 1 0 	1 1 1 1 1 0 0 0 
*	1 1 0 1 1 1 0 0 	0 1 1 1 0 1 0 0 
*	0 1 0 1 1 1 0 0 	1 1 1 0 1 0 1 0 
*	1 1 0 0 0 0 0 0 	1 0 0 0 1 0 1 0 
*	1 1 1 1 0 1 0 0 	1 1 0 1 0 0 0 0 
*	0 1 0 1 1 1 1 1 	1 1 0 1 1 0 0 1 
*****************************************************/

module AES_SBox_GF_2_4_PolyBasis_3_8_8 (out, in);

	input [7:0] in;
	output [7:0] out;

	wire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, inH_add_inL, outH, outL, d, d_inv;

	// Mapping from GF(2^8) to GF((2^4)^2)

	assign inH[3] = in[7] ^ in[5] ^ in[3] ^ in[2];
	assign inH[2] = in[6] ^ in[5] ^ in[4] ^ in[1];
	assign inH[1] = in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1];
	assign inH[0] = in[7] ^ in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[3] = in[6] ^ in[4] ^ in[3] ^ in[2];
	assign inL[2] = in[7] ^ in[6];
	assign inL[1] = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[2];
	assign inL[0] = in[6] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

	// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter

	GF_2_4_Sqr3 u_sqr_H (.q(inH2), .a(inH));
	GF_2_4_Mul3 u_mul_constE (.q(inH2E), .a(inH2), .b(4'hF));
	assign inH_add_inL = inH ^ inL;
	GF_2_4_Mul3 u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));
	assign d = inH2E ^ inL2_add_inHL;
	GF_2_4_Inv3_LUT u_inv (.out(d_inv), .in(d));
	GF_2_4_Mul3 u_mul_H_di (.q(outH), .a(inH), .b(d_inv));
	GF_2_4_Mul3 u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));

	/*****************************************************
	* Inverse Map + Affine Matrix:
	*
	*	0 1 1 0 0 0 1 0 
	*	1 1 1 1 0 0 0 0 
	*	0 0 1 1 1 1 0 0 
	*	0 0 0 1 1 1 0 1 
	*	0 1 1 1 0 0 0 1 
	*	1 0 0 0 0 1 1 1 
	*	1 1 1 1 0 1 0 1 
	*	0 1 0 1 0 0 0 1 
	*****************************************************/

	// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation

	assign out[7] = outH[2] ^ outH[1] ^ outL[1];
	assign out[6] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] );
	assign out[5] = ~( outH[1] ^ outH[0] ^ outL[3] ^ outL[2] );
	assign out[4] = outH[0] ^ outL[3] ^ outL[2] ^ outL[0];
	assign out[3] = outH[2] ^ outH[1] ^ outH[0] ^ outL[0];
	assign out[2] = outH[3] ^ outL[2] ^ outL[1] ^ outL[0];
	assign out[1] = ~( outH[3] ^ outH[2] ^ outH[1] ^ outH[0] ^ outL[2] ^ outL[0] );
	assign out[0] = ~( outH[2] ^ outH[0] ^ outL[0] );

endmodule





/************************************
*
* Wrapper for all 192 S-Boxes
*
************************************/

module AES_SBox_GF_2_4_AllPolyBases (
					out_1_1_1, out_1_1_2, out_1_1_3, out_1_1_4, out_1_1_5, out_1_1_6, out_1_1_7, out_1_1_8, 
					out_1_2_1, out_1_2_2, out_1_2_3, out_1_2_4, out_1_2_5, out_1_2_6, out_1_2_7, out_1_2_8, 
					out_1_3_1, out_1_3_2, out_1_3_3, out_1_3_4, out_1_3_5, out_1_3_6, out_1_3_7, out_1_3_8, 
					out_1_4_1, out_1_4_2, out_1_4_3, out_1_4_4, out_1_4_5, out_1_4_6, out_1_4_7, out_1_4_8, 
					out_1_5_1, out_1_5_2, out_1_5_3, out_1_5_4, out_1_5_5, out_1_5_6, out_1_5_7, out_1_5_8, 
					out_1_6_1, out_1_6_2, out_1_6_3, out_1_6_4, out_1_6_5, out_1_6_6, out_1_6_7, out_1_6_8, 
					out_1_7_1, out_1_7_2, out_1_7_3, out_1_7_4, out_1_7_5, out_1_7_6, out_1_7_7, out_1_7_8, 
					out_1_8_1, out_1_8_2, out_1_8_3, out_1_8_4, out_1_8_5, out_1_8_6, out_1_8_7, out_1_8_8, 
					out_2_1_1, out_2_1_2, out_2_1_3, out_2_1_4, out_2_1_5, out_2_1_6, out_2_1_7, out_2_1_8, 
					out_2_2_1, out_2_2_2, out_2_2_3, out_2_2_4, out_2_2_5, out_2_2_6, out_2_2_7, out_2_2_8, 
					out_2_3_1, out_2_3_2, out_2_3_3, out_2_3_4, out_2_3_5, out_2_3_6, out_2_3_7, out_2_3_8, 
					out_2_4_1, out_2_4_2, out_2_4_3, out_2_4_4, out_2_4_5, out_2_4_6, out_2_4_7, out_2_4_8, 
					out_2_5_1, out_2_5_2, out_2_5_3, out_2_5_4, out_2_5_5, out_2_5_6, out_2_5_7, out_2_5_8, 
					out_2_6_1, out_2_6_2, out_2_6_3, out_2_6_4, out_2_6_5, out_2_6_6, out_2_6_7, out_2_6_8, 
					out_2_7_1, out_2_7_2, out_2_7_3, out_2_7_4, out_2_7_5, out_2_7_6, out_2_7_7, out_2_7_8, 
					out_2_8_1, out_2_8_2, out_2_8_3, out_2_8_4, out_2_8_5, out_2_8_6, out_2_8_7, out_2_8_8, 
					out_3_1_1, out_3_1_2, out_3_1_3, out_3_1_4, out_3_1_5, out_3_1_6, out_3_1_7, out_3_1_8, 
					out_3_2_1, out_3_2_2, out_3_2_3, out_3_2_4, out_3_2_5, out_3_2_6, out_3_2_7, out_3_2_8, 
					out_3_3_1, out_3_3_2, out_3_3_3, out_3_3_4, out_3_3_5, out_3_3_6, out_3_3_7, out_3_3_8, 
					out_3_4_1, out_3_4_2, out_3_4_3, out_3_4_4, out_3_4_5, out_3_4_6, out_3_4_7, out_3_4_8, 
					out_3_5_1, out_3_5_2, out_3_5_3, out_3_5_4, out_3_5_5, out_3_5_6, out_3_5_7, out_3_5_8, 
					out_3_6_1, out_3_6_2, out_3_6_3, out_3_6_4, out_3_6_5, out_3_6_6, out_3_6_7, out_3_6_8, 
					out_3_7_1, out_3_7_2, out_3_7_3, out_3_7_4, out_3_7_5, out_3_7_6, out_3_7_7, out_3_7_8, 
					out_3_8_1, out_3_8_2, out_3_8_3, out_3_8_4, out_3_8_5, out_3_8_6, out_3_8_7, out_3_8_8, 
					in   );

	input [7:0] in;

	output [7:0] out_1_1_1;
	output [7:0] out_1_1_2;
	output [7:0] out_1_1_3;
	output [7:0] out_1_1_4;
	output [7:0] out_1_1_5;
	output [7:0] out_1_1_6;
	output [7:0] out_1_1_7;
	output [7:0] out_1_1_8;
	output [7:0] out_1_2_1;
	output [7:0] out_1_2_2;
	output [7:0] out_1_2_3;
	output [7:0] out_1_2_4;
	output [7:0] out_1_2_5;
	output [7:0] out_1_2_6;
	output [7:0] out_1_2_7;
	output [7:0] out_1_2_8;
	output [7:0] out_1_3_1;
	output [7:0] out_1_3_2;
	output [7:0] out_1_3_3;
	output [7:0] out_1_3_4;
	output [7:0] out_1_3_5;
	output [7:0] out_1_3_6;
	output [7:0] out_1_3_7;
	output [7:0] out_1_3_8;
	output [7:0] out_1_4_1;
	output [7:0] out_1_4_2;
	output [7:0] out_1_4_3;
	output [7:0] out_1_4_4;
	output [7:0] out_1_4_5;
	output [7:0] out_1_4_6;
	output [7:0] out_1_4_7;
	output [7:0] out_1_4_8;
	output [7:0] out_1_5_1;
	output [7:0] out_1_5_2;
	output [7:0] out_1_5_3;
	output [7:0] out_1_5_4;
	output [7:0] out_1_5_5;
	output [7:0] out_1_5_6;
	output [7:0] out_1_5_7;
	output [7:0] out_1_5_8;
	output [7:0] out_1_6_1;
	output [7:0] out_1_6_2;
	output [7:0] out_1_6_3;
	output [7:0] out_1_6_4;
	output [7:0] out_1_6_5;
	output [7:0] out_1_6_6;
	output [7:0] out_1_6_7;
	output [7:0] out_1_6_8;
	output [7:0] out_1_7_1;
	output [7:0] out_1_7_2;
	output [7:0] out_1_7_3;
	output [7:0] out_1_7_4;
	output [7:0] out_1_7_5;
	output [7:0] out_1_7_6;
	output [7:0] out_1_7_7;
	output [7:0] out_1_7_8;
	output [7:0] out_1_8_1;
	output [7:0] out_1_8_2;
	output [7:0] out_1_8_3;
	output [7:0] out_1_8_4;
	output [7:0] out_1_8_5;
	output [7:0] out_1_8_6;
	output [7:0] out_1_8_7;
	output [7:0] out_1_8_8;
	output [7:0] out_2_1_1;
	output [7:0] out_2_1_2;
	output [7:0] out_2_1_3;
	output [7:0] out_2_1_4;
	output [7:0] out_2_1_5;
	output [7:0] out_2_1_6;
	output [7:0] out_2_1_7;
	output [7:0] out_2_1_8;
	output [7:0] out_2_2_1;
	output [7:0] out_2_2_2;
	output [7:0] out_2_2_3;
	output [7:0] out_2_2_4;
	output [7:0] out_2_2_5;
	output [7:0] out_2_2_6;
	output [7:0] out_2_2_7;
	output [7:0] out_2_2_8;
	output [7:0] out_2_3_1;
	output [7:0] out_2_3_2;
	output [7:0] out_2_3_3;
	output [7:0] out_2_3_4;
	output [7:0] out_2_3_5;
	output [7:0] out_2_3_6;
	output [7:0] out_2_3_7;
	output [7:0] out_2_3_8;
	output [7:0] out_2_4_1;
	output [7:0] out_2_4_2;
	output [7:0] out_2_4_3;
	output [7:0] out_2_4_4;
	output [7:0] out_2_4_5;
	output [7:0] out_2_4_6;
	output [7:0] out_2_4_7;
	output [7:0] out_2_4_8;
	output [7:0] out_2_5_1;
	output [7:0] out_2_5_2;
	output [7:0] out_2_5_3;
	output [7:0] out_2_5_4;
	output [7:0] out_2_5_5;
	output [7:0] out_2_5_6;
	output [7:0] out_2_5_7;
	output [7:0] out_2_5_8;
	output [7:0] out_2_6_1;
	output [7:0] out_2_6_2;
	output [7:0] out_2_6_3;
	output [7:0] out_2_6_4;
	output [7:0] out_2_6_5;
	output [7:0] out_2_6_6;
	output [7:0] out_2_6_7;
	output [7:0] out_2_6_8;
	output [7:0] out_2_7_1;
	output [7:0] out_2_7_2;
	output [7:0] out_2_7_3;
	output [7:0] out_2_7_4;
	output [7:0] out_2_7_5;
	output [7:0] out_2_7_6;
	output [7:0] out_2_7_7;
	output [7:0] out_2_7_8;
	output [7:0] out_2_8_1;
	output [7:0] out_2_8_2;
	output [7:0] out_2_8_3;
	output [7:0] out_2_8_4;
	output [7:0] out_2_8_5;
	output [7:0] out_2_8_6;
	output [7:0] out_2_8_7;
	output [7:0] out_2_8_8;
	output [7:0] out_3_1_1;
	output [7:0] out_3_1_2;
	output [7:0] out_3_1_3;
	output [7:0] out_3_1_4;
	output [7:0] out_3_1_5;
	output [7:0] out_3_1_6;
	output [7:0] out_3_1_7;
	output [7:0] out_3_1_8;
	output [7:0] out_3_2_1;
	output [7:0] out_3_2_2;
	output [7:0] out_3_2_3;
	output [7:0] out_3_2_4;
	output [7:0] out_3_2_5;
	output [7:0] out_3_2_6;
	output [7:0] out_3_2_7;
	output [7:0] out_3_2_8;
	output [7:0] out_3_3_1;
	output [7:0] out_3_3_2;
	output [7:0] out_3_3_3;
	output [7:0] out_3_3_4;
	output [7:0] out_3_3_5;
	output [7:0] out_3_3_6;
	output [7:0] out_3_3_7;
	output [7:0] out_3_3_8;
	output [7:0] out_3_4_1;
	output [7:0] out_3_4_2;
	output [7:0] out_3_4_3;
	output [7:0] out_3_4_4;
	output [7:0] out_3_4_5;
	output [7:0] out_3_4_6;
	output [7:0] out_3_4_7;
	output [7:0] out_3_4_8;
	output [7:0] out_3_5_1;
	output [7:0] out_3_5_2;
	output [7:0] out_3_5_3;
	output [7:0] out_3_5_4;
	output [7:0] out_3_5_5;
	output [7:0] out_3_5_6;
	output [7:0] out_3_5_7;
	output [7:0] out_3_5_8;
	output [7:0] out_3_6_1;
	output [7:0] out_3_6_2;
	output [7:0] out_3_6_3;
	output [7:0] out_3_6_4;
	output [7:0] out_3_6_5;
	output [7:0] out_3_6_6;
	output [7:0] out_3_6_7;
	output [7:0] out_3_6_8;
	output [7:0] out_3_7_1;
	output [7:0] out_3_7_2;
	output [7:0] out_3_7_3;
	output [7:0] out_3_7_4;
	output [7:0] out_3_7_5;
	output [7:0] out_3_7_6;
	output [7:0] out_3_7_7;
	output [7:0] out_3_7_8;
	output [7:0] out_3_8_1;
	output [7:0] out_3_8_2;
	output [7:0] out_3_8_3;
	output [7:0] out_3_8_4;
	output [7:0] out_3_8_5;
	output [7:0] out_3_8_6;
	output [7:0] out_3_8_7;
	output [7:0] out_3_8_8;

	AES_SBox_GF_2_4_PolyBasis_1_1_1 u_sbox_1_1_1 (.out(out_1_1_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_1_2 u_sbox_1_1_2 (.out(out_1_1_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_1_3 u_sbox_1_1_3 (.out(out_1_1_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_1_4 u_sbox_1_1_4 (.out(out_1_1_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_1_5 u_sbox_1_1_5 (.out(out_1_1_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_1_6 u_sbox_1_1_6 (.out(out_1_1_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_1_7 u_sbox_1_1_7 (.out(out_1_1_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_1_8 u_sbox_1_1_8 (.out(out_1_1_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_1 u_sbox_1_2_1 (.out(out_1_2_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_2 u_sbox_1_2_2 (.out(out_1_2_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_3 u_sbox_1_2_3 (.out(out_1_2_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_4 u_sbox_1_2_4 (.out(out_1_2_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_5 u_sbox_1_2_5 (.out(out_1_2_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_6 u_sbox_1_2_6 (.out(out_1_2_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_7 u_sbox_1_2_7 (.out(out_1_2_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_2_8 u_sbox_1_2_8 (.out(out_1_2_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_1 u_sbox_1_3_1 (.out(out_1_3_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_2 u_sbox_1_3_2 (.out(out_1_3_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_3 u_sbox_1_3_3 (.out(out_1_3_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_4 u_sbox_1_3_4 (.out(out_1_3_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_5 u_sbox_1_3_5 (.out(out_1_3_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_6 u_sbox_1_3_6 (.out(out_1_3_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_7 u_sbox_1_3_7 (.out(out_1_3_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_3_8 u_sbox_1_3_8 (.out(out_1_3_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_1 u_sbox_1_4_1 (.out(out_1_4_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_2 u_sbox_1_4_2 (.out(out_1_4_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_3 u_sbox_1_4_3 (.out(out_1_4_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_4 u_sbox_1_4_4 (.out(out_1_4_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_5 u_sbox_1_4_5 (.out(out_1_4_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_6 u_sbox_1_4_6 (.out(out_1_4_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_7 u_sbox_1_4_7 (.out(out_1_4_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_4_8 u_sbox_1_4_8 (.out(out_1_4_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_1 u_sbox_1_5_1 (.out(out_1_5_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_2 u_sbox_1_5_2 (.out(out_1_5_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_3 u_sbox_1_5_3 (.out(out_1_5_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_4 u_sbox_1_5_4 (.out(out_1_5_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_5 u_sbox_1_5_5 (.out(out_1_5_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_6 u_sbox_1_5_6 (.out(out_1_5_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_7 u_sbox_1_5_7 (.out(out_1_5_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_5_8 u_sbox_1_5_8 (.out(out_1_5_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_1 u_sbox_1_6_1 (.out(out_1_6_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_2 u_sbox_1_6_2 (.out(out_1_6_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_3 u_sbox_1_6_3 (.out(out_1_6_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_4 u_sbox_1_6_4 (.out(out_1_6_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_5 u_sbox_1_6_5 (.out(out_1_6_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_6 u_sbox_1_6_6 (.out(out_1_6_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_7 u_sbox_1_6_7 (.out(out_1_6_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_6_8 u_sbox_1_6_8 (.out(out_1_6_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_1 u_sbox_1_7_1 (.out(out_1_7_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_2 u_sbox_1_7_2 (.out(out_1_7_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_3 u_sbox_1_7_3 (.out(out_1_7_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_4 u_sbox_1_7_4 (.out(out_1_7_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_5 u_sbox_1_7_5 (.out(out_1_7_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_6 u_sbox_1_7_6 (.out(out_1_7_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_7 u_sbox_1_7_7 (.out(out_1_7_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_7_8 u_sbox_1_7_8 (.out(out_1_7_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_1 u_sbox_1_8_1 (.out(out_1_8_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_2 u_sbox_1_8_2 (.out(out_1_8_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_3 u_sbox_1_8_3 (.out(out_1_8_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_4 u_sbox_1_8_4 (.out(out_1_8_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_5 u_sbox_1_8_5 (.out(out_1_8_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_6 u_sbox_1_8_6 (.out(out_1_8_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_7 u_sbox_1_8_7 (.out(out_1_8_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_1_8_8 u_sbox_1_8_8 (.out(out_1_8_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_1 u_sbox_2_1_1 (.out(out_2_1_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_2 u_sbox_2_1_2 (.out(out_2_1_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_3 u_sbox_2_1_3 (.out(out_2_1_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_4 u_sbox_2_1_4 (.out(out_2_1_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_5 u_sbox_2_1_5 (.out(out_2_1_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_6 u_sbox_2_1_6 (.out(out_2_1_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_7 u_sbox_2_1_7 (.out(out_2_1_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_1_8 u_sbox_2_1_8 (.out(out_2_1_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_1 u_sbox_2_2_1 (.out(out_2_2_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_2 u_sbox_2_2_2 (.out(out_2_2_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_3 u_sbox_2_2_3 (.out(out_2_2_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_4 u_sbox_2_2_4 (.out(out_2_2_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_5 u_sbox_2_2_5 (.out(out_2_2_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_6 u_sbox_2_2_6 (.out(out_2_2_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_7 u_sbox_2_2_7 (.out(out_2_2_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_2_8 u_sbox_2_2_8 (.out(out_2_2_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_1 u_sbox_2_3_1 (.out(out_2_3_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_2 u_sbox_2_3_2 (.out(out_2_3_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_3 u_sbox_2_3_3 (.out(out_2_3_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_4 u_sbox_2_3_4 (.out(out_2_3_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_5 u_sbox_2_3_5 (.out(out_2_3_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_6 u_sbox_2_3_6 (.out(out_2_3_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_7 u_sbox_2_3_7 (.out(out_2_3_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_3_8 u_sbox_2_3_8 (.out(out_2_3_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_1 u_sbox_2_4_1 (.out(out_2_4_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_2 u_sbox_2_4_2 (.out(out_2_4_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_3 u_sbox_2_4_3 (.out(out_2_4_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_4 u_sbox_2_4_4 (.out(out_2_4_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_5 u_sbox_2_4_5 (.out(out_2_4_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_6 u_sbox_2_4_6 (.out(out_2_4_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_7 u_sbox_2_4_7 (.out(out_2_4_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_4_8 u_sbox_2_4_8 (.out(out_2_4_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_1 u_sbox_2_5_1 (.out(out_2_5_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_2 u_sbox_2_5_2 (.out(out_2_5_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_3 u_sbox_2_5_3 (.out(out_2_5_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_4 u_sbox_2_5_4 (.out(out_2_5_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_5 u_sbox_2_5_5 (.out(out_2_5_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_6 u_sbox_2_5_6 (.out(out_2_5_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_7 u_sbox_2_5_7 (.out(out_2_5_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_5_8 u_sbox_2_5_8 (.out(out_2_5_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_1 u_sbox_2_6_1 (.out(out_2_6_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_2 u_sbox_2_6_2 (.out(out_2_6_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_3 u_sbox_2_6_3 (.out(out_2_6_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_4 u_sbox_2_6_4 (.out(out_2_6_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_5 u_sbox_2_6_5 (.out(out_2_6_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_6 u_sbox_2_6_6 (.out(out_2_6_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_7 u_sbox_2_6_7 (.out(out_2_6_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_6_8 u_sbox_2_6_8 (.out(out_2_6_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_1 u_sbox_2_7_1 (.out(out_2_7_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_2 u_sbox_2_7_2 (.out(out_2_7_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_3 u_sbox_2_7_3 (.out(out_2_7_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_4 u_sbox_2_7_4 (.out(out_2_7_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_5 u_sbox_2_7_5 (.out(out_2_7_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_6 u_sbox_2_7_6 (.out(out_2_7_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_7 u_sbox_2_7_7 (.out(out_2_7_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_7_8 u_sbox_2_7_8 (.out(out_2_7_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_1 u_sbox_2_8_1 (.out(out_2_8_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_2 u_sbox_2_8_2 (.out(out_2_8_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_3 u_sbox_2_8_3 (.out(out_2_8_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_4 u_sbox_2_8_4 (.out(out_2_8_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_5 u_sbox_2_8_5 (.out(out_2_8_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_6 u_sbox_2_8_6 (.out(out_2_8_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_7 u_sbox_2_8_7 (.out(out_2_8_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_2_8_8 u_sbox_2_8_8 (.out(out_2_8_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_1 u_sbox_3_1_1 (.out(out_3_1_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_2 u_sbox_3_1_2 (.out(out_3_1_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_3 u_sbox_3_1_3 (.out(out_3_1_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_4 u_sbox_3_1_4 (.out(out_3_1_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_5 u_sbox_3_1_5 (.out(out_3_1_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_6 u_sbox_3_1_6 (.out(out_3_1_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_7 u_sbox_3_1_7 (.out(out_3_1_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_1_8 u_sbox_3_1_8 (.out(out_3_1_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_1 u_sbox_3_2_1 (.out(out_3_2_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_2 u_sbox_3_2_2 (.out(out_3_2_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_3 u_sbox_3_2_3 (.out(out_3_2_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_4 u_sbox_3_2_4 (.out(out_3_2_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_5 u_sbox_3_2_5 (.out(out_3_2_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_6 u_sbox_3_2_6 (.out(out_3_2_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_7 u_sbox_3_2_7 (.out(out_3_2_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_2_8 u_sbox_3_2_8 (.out(out_3_2_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_1 u_sbox_3_3_1 (.out(out_3_3_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_2 u_sbox_3_3_2 (.out(out_3_3_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_3 u_sbox_3_3_3 (.out(out_3_3_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_4 u_sbox_3_3_4 (.out(out_3_3_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_5 u_sbox_3_3_5 (.out(out_3_3_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_6 u_sbox_3_3_6 (.out(out_3_3_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_7 u_sbox_3_3_7 (.out(out_3_3_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_3_8 u_sbox_3_3_8 (.out(out_3_3_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_1 u_sbox_3_4_1 (.out(out_3_4_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_2 u_sbox_3_4_2 (.out(out_3_4_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_3 u_sbox_3_4_3 (.out(out_3_4_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_4 u_sbox_3_4_4 (.out(out_3_4_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_5 u_sbox_3_4_5 (.out(out_3_4_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_6 u_sbox_3_4_6 (.out(out_3_4_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_7 u_sbox_3_4_7 (.out(out_3_4_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_4_8 u_sbox_3_4_8 (.out(out_3_4_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_1 u_sbox_3_5_1 (.out(out_3_5_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_2 u_sbox_3_5_2 (.out(out_3_5_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_3 u_sbox_3_5_3 (.out(out_3_5_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_4 u_sbox_3_5_4 (.out(out_3_5_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_5 u_sbox_3_5_5 (.out(out_3_5_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_6 u_sbox_3_5_6 (.out(out_3_5_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_7 u_sbox_3_5_7 (.out(out_3_5_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_5_8 u_sbox_3_5_8 (.out(out_3_5_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_1 u_sbox_3_6_1 (.out(out_3_6_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_2 u_sbox_3_6_2 (.out(out_3_6_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_3 u_sbox_3_6_3 (.out(out_3_6_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_4 u_sbox_3_6_4 (.out(out_3_6_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_5 u_sbox_3_6_5 (.out(out_3_6_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_6 u_sbox_3_6_6 (.out(out_3_6_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_7 u_sbox_3_6_7 (.out(out_3_6_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_6_8 u_sbox_3_6_8 (.out(out_3_6_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_1 u_sbox_3_7_1 (.out(out_3_7_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_2 u_sbox_3_7_2 (.out(out_3_7_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_3 u_sbox_3_7_3 (.out(out_3_7_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_4 u_sbox_3_7_4 (.out(out_3_7_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_5 u_sbox_3_7_5 (.out(out_3_7_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_6 u_sbox_3_7_6 (.out(out_3_7_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_7 u_sbox_3_7_7 (.out(out_3_7_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_7_8 u_sbox_3_7_8 (.out(out_3_7_8), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_1 u_sbox_3_8_1 (.out(out_3_8_1), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_2 u_sbox_3_8_2 (.out(out_3_8_2), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_3 u_sbox_3_8_3 (.out(out_3_8_3), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_4 u_sbox_3_8_4 (.out(out_3_8_4), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_5 u_sbox_3_8_5 (.out(out_3_8_5), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_6 u_sbox_3_8_6 (.out(out_3_8_6), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_7 u_sbox_3_8_7 (.out(out_3_8_7), .in(in));
	AES_SBox_GF_2_4_PolyBasis_3_8_8 u_sbox_3_8_8 (.out(out_3_8_8), .in(in));

endmodule




/************************************
* END OF FILE
************************************/


