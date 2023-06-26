/*****************************************************
*         _____  ___________ _________
*        /  _  \ \_   _____//   _____/
*       /  /_\  \ |    __)_ \_____  \ 
*      /    |    \|        \/        \
*      \____|__  /_______  /_______  /
*              \/        \/        \/ 
*
*****************************************************/

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
* COMMON AES S-BOX SUB-MODULES
*
*****************************************************/

/***********************************************************************
*
* Affine & Inverse Affine Transformations
*
* Ref: Morioka and Satoh, CHES 2002
*
***********************************************************************/

// Affine Transformation over AES Field

module SBox_Affine (y, x);

	input	[7:0]	x;

	output	[7:0]	y;

	assign y[0] = ~(x[0] ^ x[4] ^ x[5] ^ x[6] ^ x[7]);
	assign y[1] = ~(x[0] ^ x[1] ^ x[5] ^ x[6] ^ x[7]);
	assign y[2] = x[0] ^ x[1] ^ x[2] ^ x[6] ^ x[7];
	assign y[3] = x[0] ^ x[1] ^ x[2] ^ x[3] ^ x[7];
	assign y[4] = x[0] ^ x[1] ^ x[2] ^ x[3] ^ x[4];
	assign y[5] = ~(x[1] ^ x[2] ^ x[3] ^ x[4] ^ x[5]);
	assign y[6] = ~(x[2] ^ x[3] ^ x[4] ^ x[5] ^ x[6]);
	assign y[7] = x[3] ^ x[4] ^ x[5] ^ x[6] ^ x[7];

endmodule

// Inverse Affine Transformation over AES Field

module SBox_InvAffine (y, x);

	input	[7:0]	x;

	output	[7:0]	y;

	assign y[0] = ~(x[2] ^ x[5] ^ x[7]);
	assign y[1] = x[0] ^ x[3] ^ x[6];
	assign y[2] = ~(x[1] ^ x[4] ^ x[7]);
	assign y[3] = x[0] ^ x[2] ^ x[5];
	assign y[4] = x[1] ^ x[3] ^ x[6];
	assign y[5] = x[2] ^ x[4] ^ x[7];
	assign y[6] = x[0] ^ x[3] ^ x[5];
	assign y[7] = x[1] ^ x[4] ^ x[6];

endmodule

/***********************************************************************
*
* GF(2^4) Arithmetic
* 
* Ref: Wolkerstorfer et al, CT-RSA 2002
* Ref: Gueron et al, ECH 2004
*
***********************************************************************/

// ------------------------------------
// m(x) = x^4 + x + 1
// ------------------------------------

// GF(2^4) Multiplier with irreducible polynomial m1(x) = x^4 + x + 1

module GF_2_4_Mul1 (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    assign q[0] = (a[0] & b[0]) ^ (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]);
    assign q[1] = (a[3] & b[2]) ^ (a[2] & b[3]) ^ (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]) ^ (a[1] & b[0]) ^ (a[0] & b[1]);
    assign q[2] = (a[3] & b[3]) ^ (a[3] & b[2]) ^ (a[2] & b[3]) ^ (a[2] & b[0]) ^ (a[1] & b[1]) ^ (a[0] & b[2]);
    assign q[3] = (a[3] & b[3]) ^ (a[3] & b[0]) ^ (a[2] & b[1]) ^ (a[1] & b[2]) ^ (a[0] & b[3]);

endmodule

// GF(2^4) Squarer with irreducible polynomial m1(x) = x^4 + x + 1
 
module GF_2_4_Sqr1 (q, a);
 
    input   [3:0]   a;
 
    output  [3:0]   q;

    assign q[0] = a[0] ^ a[2];
    assign q[1] = a[2];
    assign q[2] = a[1] ^ a[3];
    assign q[3] = a[3];

endmodule

// GF(2^4) Inverter  with irreducible polynomial m1(x) = x^4 + x + 1
 
module GF_2_4_Inv1 (q, a);
 
    input   [3:0]   a;

    output  [3:0]   q;

    wire    t;

    assign t = a[1] ^ a[2] ^ a[3] ^ (a[1] & a[2] & a[3]);

    assign q[0] = t ^ a[0] ^ (a[0] & a[2]) ^ (a[1] & a[2]) ^ (a[0] & a[1] & a[2]);
    assign q[1] = (a[0] & a[1]) ^ (a[0] & a[2]) ^ (a[1] & a[2]) ^ a[3] ^ (a[1] & a[3]) ^ (a[0] & a[1] & a[3]);
    assign q[2] = (a[0] & a[1]) ^ a[2] ^ (a[0] & a[2]) ^ a[3] ^ (a[0] & a[3]) ^ (a[0] & a[2] & a[3]);
    assign q[3] = t ^ (a[0] & a[3]) ^ (a[1] & a[3]) ^ (a[2] & a[3]);

endmodule

// ------------------------------------
// m(x) = x^4 + x^3 + 1
// ------------------------------------

// GF(2^4) Multiplier with irreducible polynomial m2(x) = x^4 + x^3 + 1

module GF_2_4_Mul2 (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    assign q[0] = (a[3] & b[3]) ^ (a[3] & b[2]) ^ (a[2] & b[3]) ^ (a[0] & b[0]) ^ (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]);
    assign q[1] = (a[3] & b[3]) ^ (a[3] & b[2]) ^ (a[2] & b[3]) ^ (a[1] & b[0]) ^ (a[0] & b[1]);
    assign q[2] = (a[3] & b[3]) ^ (a[2] & b[0]) ^ (a[1] & b[1]) ^ (a[0] & b[2]);
    assign q[3] = (a[3] & b[3]) ^ (a[3] & b[2]) ^ (a[2] & b[3]) ^ (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]) ^ (a[3] & b[0]) ^ (a[2] & b[1]) ^ (a[1] & b[2]) ^ (a[0] & b[3]);

endmodule

// GF(2^4) Squarer with irreducible polynomial m2(x) = x^4 + x^3 + 1
 
module GF_2_4_Sqr2 (q, a);
 
    input   [3:0]   a;
 
    output  [3:0]   q;

    assign q[0] = a[0] ^ a[2] ^ a[3];
    assign q[1] = a[3];
    assign q[2] = a[1] ^ a[3];
    assign q[3] = a[2] ^ a[3];

endmodule

// GF(2^4) Inverter  with irreducible polynomial m2(x) = x^4 + x^3 + 1
 
// module GF_2_4_Inv2 (q, a);
//  
//     input   [3:0]   a;
// 
//     output  [3:0]   q;
// 
// endmodule

// ------------------------------------
// m(x) = x^4 + x^3 + x^2 + x + 1
// ------------------------------------

// GF(2^4) Multiplier with irreducible polynomial m3(x) = x^4 + x^3 + x^2 + x + 1

module GF_2_4_Mul3 (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    assign q[0] = (a[0] & b[0]) ^ (a[3] & b[2]) ^ (a[2] & b[3]) ^ (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]);
    assign q[1] = (a[3] & b[3]) ^ (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]) ^ (a[1] & b[0]) ^ (a[0] & b[1]);
    assign q[2] = (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]) ^ (a[2] & b[0]) ^ (a[1] & b[1]) ^ (a[0] & b[2]);
    assign q[3] = (a[3] & b[1]) ^ (a[2] & b[2]) ^ (a[1] & b[3]) ^ (a[3] & b[0]) ^ (a[2] & b[1]) ^ (a[1] & b[2]) ^ (a[0] & b[3]);

endmodule

// GF(2^4) Squarer with irreducible polynomial m3(x) = x^4 + x^3 + x^2 + x + 1
 
module GF_2_4_Sqr3 (q, a);
 
    input   [3:0]   a;
 
    output  [3:0]   q;

    assign q[0] = a[0] ^ a[2];
    assign q[1] = a[2] ^ a[3];
    assign q[2] = a[1] ^ a[2];
    assign q[3] = a[2];

endmodule

// GF(2^4) Inverter  with irreducible polynomial m3(x) = x^4 + x^3 + x^2 + x + 1
 
// module GF_2_4_Inv3 (q, a);
//  
//     input   [3:0]   a;
// 
//     output  [3:0]   q;
// 
// endmodule

/***********************************************************************
*
* LUT-Based GF(2^4) Inverters
*
* Ref: BitVector.py
*
***********************************************************************/

// LUT-Based GF(2^4) Inverter  with irreducible polynomial m1(x) = x^4 + x + 1
 
module GF_2_4_Inv1_LUT (out, in);
 
    input   [3:0]   in;

    output  reg [3:0]   out;

    always @(in)
        case(in)
            4'h0: out = 4'b0000;
            4'h1: out = 4'b0001;
            4'h2: out = 4'b1001;
            4'h3: out = 4'b1110;
            4'h4: out = 4'b1101;
            4'h5: out = 4'b1011;
            4'h6: out = 4'b0111;
            4'h7: out = 4'b0110;
            4'h8: out = 4'b1111;
            4'h9: out = 4'b0010;
            4'hA: out = 4'b1100;
            4'hB: out = 4'b0101;
            4'hC: out = 4'b1010;
            4'hD: out = 4'b0100;
            4'hE: out = 4'b0011;
            4'hF: out = 4'b1000;
        endcase

endmodule

// LUT-Based GF(2^4) Inverter  with irreducible polynomial m2(x) = x^4 + x^3 + 1
 
module GF_2_4_Inv2_LUT (out, in);
 
    input   [3:0]   in;

    output  reg [3:0]   out;

    always @(in)
        case(in)
            4'h0: out = 4'b0000;
            4'h1: out = 4'b0001;
            4'h2: out = 4'b1100;
            4'h3: out = 4'b1000;
            4'h4: out = 4'b0110;
            4'h5: out = 4'b1111;
            4'h6: out = 4'b0100;
            4'h7: out = 4'b1110;
            4'h8: out = 4'b0011;
            4'h9: out = 4'b1101;
            4'hA: out = 4'b1011;
            4'hB: out = 4'b1010;
            4'hC: out = 4'b0010;
            4'hD: out = 4'b1001;
            4'hE: out = 4'b0111;
            4'hF: out = 4'b0101;
        endcase

endmodule

// LUT-Based GF(2^4) Inverter  with irreducible polynomial m3(x) = x^4 + x^3 + x^2 + x + 1
 
module GF_2_4_Inv3_LUT (out, in);
 
    input   [3:0]   in;

    output  reg [3:0]   out;

    always @(in)
        case(in)
            4'h0: out = 4'b0000;
            4'h1: out = 4'b0001;
            4'h2: out = 4'b1111;
            4'h3: out = 4'b1010;
            4'h4: out = 4'b1000;
            4'h5: out = 4'b0110;
            4'h6: out = 4'b0101;
            4'h7: out = 4'b1001;
            4'h8: out = 4'b0100;
            4'h9: out = 4'b0111;
            4'hA: out = 4'b0011;
            4'hB: out = 4'b1110;
            4'hC: out = 4'b1101;
            4'hD: out = 4'b1100;
            4'hE: out = 4'b1011;
            4'hF: out = 4'b0010;
        endcase

endmodule

/***********************************************************************
*
* GF(((2^2)^2)^2) Arithmetic
*
* Ref: Canright, CHES 2005
*
***********************************************************************/

////////////////////////////////////////////////////////////////////////
// POLYNOMIAL BASIS ONLY
////////////////////////////////////////////////////////////////////////

// GF(2^2) / GF(2): w^2 + w + 1

// Polynomial Basis GF(2^2) Multiplier

module GF_2_2_MUL_Poly (q, a, b);

    input   [1:0]   a, b;

    output  [1:0]   q;

    wire    t;

    assign t = a[0] & b[0];

    assign q[1] = t ^ ((a[1] ^ a[0]) & (b[1] ^ b[0]));
    assign q[0] = t ^ (a[1] & b[1]);

endmodule

// Polynomial Basis GF(2^2) Inverter

module GF_2_2_INV_Poly (q, a);

    input   [1:0]   a;

    output  [1:0]   q;

    assign q[1] = a[1];
    assign q[0] = a[1] ^ a[0];

endmodule

// Polynomial Basis GF(2^2) Squarer

module GF_2_2_SQR_Poly (q, a);

    input   [1:0]   a;

    output  [1:0]   q;

    assign q[1] = a[1];
    assign q[0] = a[1] ^ a[0];

endmodule

// Polynomial Basis GF(2^2) w-Scaler

module GF_2_2_SCLw_Poly (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[1] ^ a[0];
    assign q[0] = a[1];

endmodule

// Polynomial Basis GF(2^2) w^2-Scaler

module GF_2_2_SCLw2_Poly (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[0];
    assign q[0] = a[1] ^ a[0];

endmodule

// Polynomial Basis GF(2^2) Squarer-w-Scaler

module GF_2_2_SQR_SCLw_Poly (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[0];
    assign q[0] = a[1];

endmodule

// Polynomial Basis GF(2^2) Squarer-w^2-Scaler

module GF_2_2_SQR_SCLw2_Poly (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[1] ^ a[0];
    assign q[0] = a[0];

endmodule

// GF(2^4) / GF(2^2): z^2 + z + N

// Polynomial-Polynomial Basis GF(2^4) Multiplier with N = w

module GF_2_4_MUL_Nw_PolyPoly (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Poly u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Poly u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw_Poly u_scl (.q(t3), .a(t1));

    assign q = {(t2 ^ t0), (t3 ^ t0)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Multiplier with N = w^2

module GF_2_4_MUL_Nw2_PolyPoly (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Poly u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Poly u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw2_Poly u_scl (.q(t3), .a(t1));

    assign q = {(t2 ^ t0), (t3 ^ t0)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Inverter with N = w

module GF_2_4_INV_Nw_PolyPoly (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(t), .b(a[1:0]));

    GF_2_2_SQR_SCLw_Poly u_sqr_scl (.q(t1), .a(a[3:2]));

    GF_2_2_INV_Poly u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Poly u_mul_1 (.q(q1), .a(t2), .b(a[3:2]));

    GF_2_2_MUL_Poly u_mul_2 (.q(q0), .a(t2), .b(t));

    assign q = {q1, q0};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Inverter with N = w^2

module GF_2_4_INV_Nw2_PolyPoly (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(t), .b(a[1:0]));

    GF_2_2_SQR_SCLw2_Poly u_sqr_scl (.q(t1), .a(a[3:2]));

    GF_2_2_INV_Poly u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Poly u_mul_1 (.q(q1), .a(t2), .b(a[3:2]));

    GF_2_2_MUL_Poly u_mul_2 (.q(q0), .a(t2), .b(t));

    assign q = {q1, q0};

endmodule

// Optimized GF(2^4) Squarer-Scalers for Polynomial-Polynomial Basis
// Auto-Generated using gen_GF_2_4_SQR_SCL_Poly

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N_0_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_0_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N_1_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_1_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N2_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N2_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_0_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_0_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_1_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_1_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N2_Nw_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Polynomial Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N2_Nw2_PolyPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

////////////////////////////////////////////////////////////////////////
// NORMAL BASIS ONLY
////////////////////////////////////////////////////////////////////////

// GF(2^2) / GF(2): w^2 + w + 1

// Normal Basis GF(2^2) Multiplier

module GF_2_2_MUL_Norm (q, a, b);

    input   [1:0]   a, b;

    output  [1:0]   q;

    wire    t;

    assign t = (a[1] ^ a[0]) & (b[1] ^ b[0]);

    assign q[1] = t ^ (a[1] & b[1]);
    assign q[0] = t ^ (a[0] & b[0]);

endmodule

// Normal Basis GF(2^2) Inverter

module GF_2_2_INV_Norm (q, a);

    input   [1:0]   a;

    output  [1:0]   q;

    assign q[1] = a[0];
    assign q[0] = a[1];

endmodule

// Normal Basis GF(2^2) Squarer

module GF_2_2_SQR_Norm (q, a);

    input   [1:0]   a;

    output  [1:0]   q;

    assign q[1] = a[0];
    assign q[0] = a[1];

endmodule

// Normal Basis GF(2^2) w-Scaler

module GF_2_2_SCLw_Norm (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[1] ^ a[0];
    assign q[0] = a[1];

endmodule

// Normal Basis GF(2^2) w^2-Scaler

module GF_2_2_SCLw2_Norm (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[0];
    assign q[0] = a[1] ^ a[0];

endmodule

// Normal Basis GF(2^2) Squarer-w-Scaler

module GF_2_2_SQR_SCLw_Norm (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[1] ^ a[0];
    assign q[0] = a[0];

endmodule

// Normal Basis GF(2^2) Squarer-w^2-Scaler

module GF_2_2_SQR_SCLw2_Norm (q, a);

    input   [1:0]   a;
    
    output  [1:0]   q;

    assign q[1] = a[1];
    assign q[0] = a[1] ^ a[0];

endmodule

// GF(2^4) / GF(2^2): z^2 + z + N

// Normal-Normal Basis GF(2^4) Multiplier with N = w

module GF_2_4_MUL_Nw_NormNorm (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Norm u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Norm u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw_Norm u_scl (.q(t3), .a(t2));

    assign q = {(t3 ^ t1), (t3 ^ t0)};

endmodule

// Normal-Normal Basis GF(2^4) Multiplier with N = w^2

module GF_2_4_MUL_Nw2_NormNorm (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Norm u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Norm u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw2_Norm u_scl (.q(t3), .a(t2));

    assign q = {(t3 ^ t1), (t3 ^ t0)};

endmodule

// Normal-Normal Basis GF(2^4) Inverter with N = w

module GF_2_4_INV_Nw_NormNorm (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[3:2]), .b(a[1:0]));

    GF_2_2_SQR_SCLw_Norm u_sqr_scl (.q(t1), .a(t));

    GF_2_2_INV_Norm u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Norm u_mul_1 (.q(q1), .a(t2), .b(a[1:0]));

    GF_2_2_MUL_Norm u_mul_2 (.q(q0), .a(t2), .b(a[3:2]));

    assign q = {q1, q0};

endmodule

// Normal-Normal Basis GF(2^4) Inverter with N = w^2

module GF_2_4_INV_Nw2_NormNorm (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[3:2]), .b(a[1:0]));

    GF_2_2_SQR_SCLw2_Norm u_sqr_scl (.q(t1), .a(t));

    GF_2_2_INV_Norm u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Norm u_mul_1 (.q(q1), .a(t2), .b(a[1:0]));

    GF_2_2_MUL_Norm u_mul_2 (.q(q0), .a(t2), .b(a[3:2]));

    assign q = {q1, q0};

endmodule

// Optimized GF(2^4) Squarer-Scalers for Normal-Normal Basis
// Auto-Generated using gen_GF_2_4_SQR_SCL_Norm

// Normal-Normal Basis GF(2^4) Squarer-(0,0)-Scaler with N = w

module GF_2_4_SQR_SCL_0_0_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	assign t00 = t10;

	assign t11 = 2'b00;

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(0,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_0_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	assign t00 = t10;

	assign t11 = 2'b00;

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(0,1)-Scaler with N = w

module GF_2_4_SQR_SCL_0_1_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(0,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_1_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(0,N)-Scaler with N = w

module GF_2_4_SQR_SCL_0_N_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(0,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_N_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(0,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_0_N2_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(0,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_N2_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,0)-Scaler with N = w

module GF_2_4_SQR_SCL_1_0_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_0_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,1)-Scaler with N = w

module GF_2_4_SQR_SCL_1_1_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_1_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,N)-Scaler with N = w

module GF_2_4_SQR_SCL_1_N_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_N_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_1_N2_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(1,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_N2_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N_0_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_0_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N_1_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_1_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N2_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N2_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_0_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_0_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_1_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_1_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N2_Nw_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Normal Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N2_Nw2_NormNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

////////////////////////////////////////////////////////////////////////
// POLYNOMIAL BASIS OVER NORMAL BASIS
////////////////////////////////////////////////////////////////////////

// GF(2^4) / GF(2^2): z^2 + z + N

// Polynomial-Normal Basis GF(2^4) Multiplier with N = w

module GF_2_4_MUL_Nw_PolyNorm (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Norm u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Norm u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw_Norm u_scl (.q(t3), .a(t1));

    assign q = {(t2 ^ t0), (t3 ^ t0)};

endmodule

// Polynomial-Normal Basis GF(2^4) Multiplier with N = w^2

module GF_2_4_MUL_Nw2_PolyNorm (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Norm u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Norm u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw2_Norm u_scl (.q(t3), .a(t1));

    assign q = {(t2 ^ t0), (t3 ^ t0)};

endmodule

// Polynomial-Normal Basis GF(2^4) Inverter with N = w

module GF_2_4_INV_Nw_PolyNorm (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(t), .b(a[1:0]));

    GF_2_2_SQR_SCLw_Norm u_sqr_scl (.q(t1), .a(a[3:2]));

    GF_2_2_INV_Norm u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Norm u_mul_1 (.q(q1), .a(t2), .b(a[3:2]));

    GF_2_2_MUL_Norm u_mul_2 (.q(q0), .a(t2), .b(t));

    assign q = {q1, q0};

endmodule

// Polynomial-Normal Basis GF(2^4) Inverter with N = w^2

module GF_2_4_INV_Nw2_PolyNorm (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Norm u_mul_0 (.q(t0), .a(t), .b(a[1:0]));

    GF_2_2_SQR_SCLw2_Norm u_sqr_scl (.q(t1), .a(a[3:2]));

    GF_2_2_INV_Norm u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Norm u_mul_1 (.q(q1), .a(t2), .b(a[3:2]));

    GF_2_2_MUL_Norm u_mul_2 (.q(q0), .a(t2), .b(t));

    assign q = {q1, q0};

endmodule

// Optimized GF(2^4) Squarer-Scalers for Polynomial-Normal Basis
// Auto-Generated using gen_GF_2_4_SQR_SCL_Poly

// Polynomial-Normal Basis GF(2^4) Squarer-(N,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N_0_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_0_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N_1_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_1_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N2_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N2_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_0_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_0_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_1_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_1_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N2_Nw_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Polynomial-Normal Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N2_Nw2_PolyNorm (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	GF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

////////////////////////////////////////////////////////////////////////
// NORMAL BASIS OVER POLYNOMIAL BASIS
////////////////////////////////////////////////////////////////////////

// GF(2^4) / GF(2^2): z^2 + z + N

// Normal-Polynomial Basis GF(2^4) Multiplier with N = w

module GF_2_4_MUL_Nw_NormPoly (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Poly u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Poly u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw_Poly u_scl (.q(t3), .a(t2));

    assign q = {(t3 ^ t1), (t3 ^ t0)};

endmodule

// Normal-Polynomial Basis GF(2^4) Multiplier with N = w^2

module GF_2_4_MUL_Nw2_NormPoly (q, a, b);

    input   [3:0]   a, b;

    output  [3:0]   q;

    wire    [1:0]   t0, t1, t2, t3;

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(a[1:0]), .b(b[1:0]));
    
    GF_2_2_MUL_Poly u_mul_1 (.q(t1), .a(a[3:2]), .b(b[3:2]));
    
    GF_2_2_MUL_Poly u_mul_2 (.q(t2), .a(a[3:2] ^ a[1:0]), .b(b[3:2] ^ b[1:0]));

    GF_2_2_SCLw2_Poly u_scl (.q(t3), .a(t2));

    assign q = {(t3 ^ t1), (t3 ^ t0)};

endmodule

// Normal-Polynomial Basis GF(2^4) Inverter with N = w

module GF_2_4_INV_Nw_NormPoly (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(a[3:2]), .b(a[1:0]));

    GF_2_2_SQR_SCLw_Poly u_sqr_scl (.q(t1), .a(t));

    GF_2_2_INV_Poly u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Poly u_mul_1 (.q(q1), .a(t2), .b(a[1:0]));

    GF_2_2_MUL_Poly u_mul_2 (.q(q0), .a(t2), .b(a[3:2]));

    assign q = {q1, q0};

endmodule

// Normal-Polynomial Basis GF(2^4) Inverter with N = w^2

module GF_2_4_INV_Nw2_NormPoly (q, a);

    input   [3:0]   a;

    output  [3:0]   q;

    wire    [1:0]   t, t0, t1, t2, q1, q0;

    assign t = a[3:2] ^ a[1:0];

    GF_2_2_MUL_Poly u_mul_0 (.q(t0), .a(a[3:2]), .b(a[1:0]));

    GF_2_2_SQR_SCLw2_Poly u_sqr_scl (.q(t1), .a(t));

    GF_2_2_INV_Poly u_inv (.q(t2), .a(t0 ^ t1));

    GF_2_2_MUL_Poly u_mul_1 (.q(q1), .a(t2), .b(a[1:0]));

    GF_2_2_MUL_Poly u_mul_2 (.q(q0), .a(t2), .b(a[3:2]));

    assign q = {q1, q0};

endmodule

// Optimized GF(2^4) Squarer-Scalers for Normal-Polynomial Basis
// Auto-Generated using gen_GF_2_4_SQR_SCL_Norm

// Normal-Polynomial Basis GF(2^4) Squarer-(0,0)-Scaler with N = w

module GF_2_4_SQR_SCL_0_0_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	assign t00 = t10;

	assign t11 = 2'b00;

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(0,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_0_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	assign t00 = t10;

	assign t11 = 2'b00;

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(0,1)-Scaler with N = w

module GF_2_4_SQR_SCL_0_1_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(0,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_1_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(0,N)-Scaler with N = w

module GF_2_4_SQR_SCL_0_N_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(0,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_N_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(0,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_0_N2_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(0,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_0_N2_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = 2'b00;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,0)-Scaler with N = w

module GF_2_4_SQR_SCL_1_0_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_0_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,1)-Scaler with N = w

module GF_2_4_SQR_SCL_1_1_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_1_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,N)-Scaler with N = w

module GF_2_4_SQR_SCL_1_N_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_N_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_1_N2_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(1,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_1_N2_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N_0_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_0_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N_1_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_1_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N_N2_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N_N2_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_0_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,0)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_0_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	assign t10 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_1_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,1)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_1_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));

	assign t01 = t11;

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,N)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));

	assign t00 = t10;

	assign t11 = 2'b00;

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w

module GF_2_4_SQR_SCL_N2_N2_Nw_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule

// Normal-Polynomial Basis GF(2^4) Squarer-(N2,N2)-Scaler with N = w2

module GF_2_4_SQR_SCL_N2_N2_Nw2_NormPoly (q, a);

	input	[3:0]	a;

	output	[3:0]	q;

	wire	[1:0]	t00, t01, t10, t11;

	GF_2_2_SQR_Poly u_sqr_10 (.q(t10), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));

	GF_2_2_SQR_SCLw2_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));

	GF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));

	assign q = {(t10 ^ t11), (t00 ^ t01)};

endmodule


