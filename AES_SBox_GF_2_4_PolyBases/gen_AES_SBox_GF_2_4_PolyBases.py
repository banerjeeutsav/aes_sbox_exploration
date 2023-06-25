#! /usr/local/bin/python

#=====================================================
# Last Modified: Utsav Banerjee (25th June 2023)
#=====================================================

import os, binascii
import numpy as np

#=====================================================
#
# Auto-Generate Verilog for 192 S-Box Designs
#
# GF(2^8): x^8 + x^4 + x^3 + x + 1
# GF(2^4): x^4 + x + 1 OR x^4 + x^3 + 1 OR x^4 + x^3 + x^2 + x + 1
# GF((2^4)^2): x^2 + x + 'N'
#
# Ref: Gueron et al, "Masked Inversion in GF (2^N) using Mixed Field Representations
#                     and its Efficient Implementation for AES," 2004
#
#=====================================================

list_poly_base = ['x^4 + x + 1',
                  'x^4 + x^3  + 1',
                  'x^4 + x^3 + x^2 + x + 1']

list_poly_ext = [['x^2 + x + 8',
                  'x^2 + x + 9',
                  'x^2 + x + A',
                  'x^2 + x + B',
                  'x^2 + x + C',
                  'x^2 + x + D',
                  'x^2 + x + E',
                  'x^2 + x + F'],
                 ['x^2 + x + 2',
                  'x^2 + x + 3',
                  'x^2 + x + 4',
                  'x^2 + x + 5',
                  'x^2 + x + 8',
                  'x^2 + x + 9',
                  'x^2 + x + E',
                  'x^2 + x + F'],
                 ['x^2 + x + 2',
                  'x^2 + x + 3',
                  'x^2 + x + 4',
                  'x^2 + x + 5',
                  'x^2 + x + 8',
                  'x^2 + x + 9',
                  'x^2 + x + E',
                  'x^2 + x + F']]

list_poly_ext_norms = [['8', '9', 'A', 'B', 'C', 'D', 'E', 'F'],
                       ['2', '3', '4', '5', '8', '9', 'E', 'F'],
                       ['2', '3', '4', '5', '8', '9', 'E', 'F']]

list_invmap = [[['01 E1 5C 0C AF 1B E3 85', # 1-1
                 '01 E1 5C 0C AE FA BF 89',
                 '01 5C E0 50 A2 02 B8 DB',
                 '01 5C E0 50 A3 5E 58 8B',
                 '01 E0 5D B0 F2 04 AD 6F',
                 '01 E0 5D B0 F3 E4 F0 DF',
                 '01 5D E1 ED 42 10 A7 92',
                 '01 5D E1 ED 43 4D 46 7F'],
                ['01 E1 5C 0C 12 4B 0F D8', # 1-2
                 '01 E1 5C 0C 13 AA 53 D4',
                 '01 5C E0 50 1E B2 B5 3A',
                 '01 5C E0 50 1F EE 55 6A',
                 '01 E0 5D B0 4E 09 A1 83',
                 '01 E0 5D B0 4F E9 FC 33',
                 '01 5D E1 ED FE 1C 16 72',  
                 '01 5D E1 ED FF 41 F7 9F'],
                ['01 E1 5C 0C 43 46 0E 39', # 1-3
                 '01 E1 5C 0C 42 A7 52 35',
                 '01 5C E0 50 AE BF 54 36',
                 '01 5C E0 50 AF E3 B4 66',
                 '01 E0 5D B0 A3 58 FD D3',
                 '01 E0 5D B0 A2 B8 A0 63',
                 '01 5D E1 ED F2 AD F6 C2',  
                 '01 5D E1 ED F3 F0 17 2F'],
                ['01 E1 5C 0C FE 16 E2 64', # 1-4
                 '01 E1 5C 0C FF F7 BE 68',
                 '01 5C E0 50 12 0F 59 D7',
                 '01 5C E0 50 13 53 B9 87',
                 '01 E0 5D B0 1F 55 F1 3F',
                 '01 E0 5D B0 1E B5 AC 8F',
                 '01 5D E1 ED 4E A1 47 22',
                 '01 5D E1 ED 4F FC A6 CF'],
                ['01 E1 5C 0C A2 1A 02 D9', # 1-5
                 '01 E1 5C 0C A3 FB 5E D5',
                 '01 5C E0 50 F3 03 E4 3B',
                 '01 5C E0 50 F2 5F 04 6B',
                 '01 E0 5D B0 43 05 4D 32',
                 '01 E0 5D B0 42 E5 10 82',
                 '01 5D E1 ED AE 11 FA 73',  
                 '01 5D E1 ED AF 4C 1B 9E'],
                ['01 E1 5C 0C 1F 4A EE 84', # 1-6
                 '01 E1 5C 0C 1E AB B2 88',
                 '01 5C E0 50 4F B3 E9 DA',
                 '01 5C E0 50 4E EF 09 8A',
                 '01 E0 5D B0 FF 08 41 DE',
                 '01 E0 5D B0 FE E8 1C 6E',
                 '01 5D E1 ED 12 1D 4B 93',  
                 '01 5D E1 ED 13 40 AA 7E'],
                ['01 E1 5C 0C 4E 47 EF 65', # 1-7
                 '01 E1 5C 0C 4F A6 B3 69',
                 '01 5C E0 50 FF BE 08 D6',
                 '01 5C E0 50 FE E2 E8 86',
                 '01 E0 5D B0 12 59 1D 8E',
                 '01 E0 5D B0 13 B9 40 3E',
                 '01 5D E1 ED 1E AC AB 23',  
                 '01 5D E1 ED 1F F1 4A CE'], 
                ['01 E1 5C 0C F3 17 03 38', # 1-8
                 '01 E1 5C 0C F2 F6 5F 34',
                 '01 5C E0 50 43 0E 05 37',
                 '01 5C E0 50 42 52 E5 67',
                 '01 E0 5D B0 AE 54 11 62',
                 '01 E0 5D B0 AF B4 4C D2',
                 '01 5D E1 ED A2 A0 1A C3',  
                 '01 5D E1 ED A3 FD FB 2E']],
               [['01 B1 EC 0C 4F 7C 80 69', # 2-1
                 '01 B1 EC 0C 4E CD 6C 65',
                 '01 EC 0D 50 FF 60 97 D6',
                 '01 EC 0D 50 FE 8C 9A 86',
                 '01 0D 51 B0 13 C7 94 3E',
                 '01 0D 51 B0 12 CA C5 8E',
                 '01 51 B1 ED 1E 24 91 23',  
                 '01 51 B1 ED 1F 75 20 CE'],
                ['01 B1 EC 0C F3 2C DC 38', # 2-2
                 '01 B1 EC 0C F2 9D 30 34',
                 '01 EC 0D 50 43 3C 7A 37',
                 '01 EC 0D 50 42 D0 77 67',
                 '01 0D 51 B0 AE 27 98 62',
                 '01 0D 51 B0 AF 2A C9 D2',
                 '01 51 B1 ED A3 28 70 2E',  
                 '01 51 B1 ED A2 79 C1 C3'],
                ['01 B1 EC 0C FF 21 60 68', # 2-3
                 '01 B1 EC 0C FE 90 8C 64',
                 '01 EC 0D 50 13 6D C7 87',
                 '01 EC 0D 50 12 81 CA D7',
                 '01 0D 51 B0 1E 96 24 8F',
                 '01 0D 51 B0 1F 9B 75 3F',
                 '01 51 B1 ED 4F 95 7C CF',  
                 '01 51 B1 ED 4E C4 CD 22'],
                ['01 B1 EC 0C 43 71 3C 39', # 2-4
                 '01 B1 EC 0C 42 C0 D0 35',
                 '01 EC 0D 50 AF 31 2A 66',
                 '01 EC 0D 50 AE DD 27 36',
                 '01 0D 51 B0 A3 76 28 D3',
                 '01 0D 51 B0 A2 7B 79 63',
                 '01 51 B1 ED F2 99 9D C2', 
                 '01 51 B1 ED F3 C8 2C 2F'],
                ['01 B1 EC 0C AF 7D 31 85', # 2-5
                 '01 B1 EC 0C AE CC DD 89',
                 '01 EC 0D 50 A2 61 7B DB',
                 '01 EC 0D 50 A3 8D 76 8B',
                 '01 0D 51 B0 F2 C6 99 6F',
                 '01 0D 51 B0 F3 CB C8 DF',
                 '01 51 B1 ED 42 25 C0 92',  
                 '01 51 B1 ED 43 74 71 7F'],
                ['01 B1 EC 0C 13 2D 6D D4', # 2-6
                 '01 B1 EC 0C 12 9C 81 D8',
                 '01 EC 0D 50 1E 3D 96 3A',
                 '01 EC 0D 50 1F D1 9B 6A',
                 '01 0D 51 B0 4F 26 95 33',
                 '01 0D 51 B0 4E 2B C4 83',
                 '01 51 B1 ED FF 29 21 9F',  
                 '01 51 B1 ED FE 78 90 72'],
                ['01 B1 EC 0C 1F 20 D1 84', # 2-7
                 '01 B1 EC 0C 1E 91 3D 88',
                 '01 EC 0D 50 4E 6C 2B 8A',
                 '01 EC 0D 50 4F 80 26 DA',
                 '01 0D 51 B0 FF 97 29 DE',
                 '01 0D 51 B0 FE 9A 78 6E',
                 '01 51 B1 ED 13 94 2D 7E',  
                 '01 51 B1 ED 12 C5 9C 93'],
                ['01 B1 EC 0C A3 70 8D D5', # 2-8
                 '01 B1 EC 0C A2 C1 61 D9',
                 '01 EC 0D 50 F2 30 C6 6B',
                 '01 EC 0D 50 F3 DC CB 3B',
                 '01 0D 51 B0 42 77 25 82',
                 '01 0D 51 B0 43 7A 74 32',
                 '01 51 B1 ED AE 98 CC 73',  
                 '01 51 B1 ED AF C9 7D 9E']],
               [['01 50 B0 0C A3 8B D3 D5', # 3-1
                 '01 50 B0 0C A2 DB 63 D9',
                 '01 B0 ED 50 F2 6F C2 6B',
                 '01 B0 ED 50 F3 DF 2F 3B',
                 '01 ED 0C B0 43 7F 39 32',
                 '01 ED 0C B0 42 92 35 82',
                 '01 0C 50 ED AF 85 66 9E',  
                 '01 0C 50 ED AE 89 36 73'],
                ['01 50 B0 0C 1E 3A 8F 88', # 3-2
                 '01 50 B0 0C 1F 6A 3F 84',
                 '01 B0 ED 50 4F 33 CF DA',
                 '01 B0 ED 50 4E 83 22 8A',
                 '01 ED 0C B0 FE 72 64 6E',
                 '01 ED 0C B0 FF 9F 68 DE',
                 '01 0C 50 ED 13 D4 87 7E',  
                 '01 0C 50 ED 12 D8 D7 93'],
                ['01 50 B0 0C F3 3B DF 38', # 3-3
                 '01 50 B0 0C F2 6B 6F 34',
                 '01 B0 ED 50 43 32 7F 37',
                 '01 B0 ED 50 42 82 92 67',
                 '01 ED 0C B0 AE 73 89 62',
                 '01 ED 0C B0 AF 9E 85 D2',
                 '01 0C 50 ED A3 D5 8B 2E',  
                 '01 0C 50 ED A2 D9 DB C3'],
                ['01 50 B0 0C 4E 8A 83 65', # 3-4
                 '01 50 B0 0C 4F DA 33 69',
                 '01 B0 ED 50 FE 6E 72 86',
                 '01 B0 ED 50 FF DE 9F D6',
                 '01 ED 0C B0 13 7E D4 3E',
                 '01 ED 0C B0 12 93 D8 8E',
                 '01 0C 50 ED 1F 84 6A CE',  
                 '01 0C 50 ED 1E 88 3A 23'],
                ['01 50 B0 0C AE 36 62 89', # 3-5
                 '01 50 B0 0C AF 66 D2 85',
                 '01 B0 ED 50 A2 63 C3 DB',
                 '01 B0 ED 50 A3 D3 2E 8B',
                 '01 ED 0C B0 F3 2F 38 DF',
                 '01 ED 0C B0 F2 C2 34 6F',
                 '01 0C 50 ED 42 35 67 92',  
                 '01 0C 50 ED 43 39 37 7F'],
                ['01 50 B0 0C 13 87 3E D4', # 3-6
                 '01 50 B0 0C 12 D7 8E D8',
                 '01 B0 ED 50 1F 3F CE 6A',
                 '01 B0 ED 50 1E 8F 23 3A',
                 '01 ED 0C B0 4E 22 65 83',
                 '01 ED 0C B0 4F CF 69 33',
                 '01 0C 50 ED FE 64 86 72',  
                 '01 0C 50 ED FF 68 D6 9F'],
                ['01 50 B0 0C FE 86 6E 64', # 3-7
                 '01 50 B0 0C FF D6 DE 68',
                 '01 B0 ED 50 13 3E 7E 87',
                 '01 B0 ED 50 12 8E 93 D7',
                 '01 ED 0C B0 1E 23 88 8F',
                 '01 ED 0C B0 1F CE 84 3F',
                 '01 0C 50 ED 4E 65 8A 22',  
                 '01 0C 50 ED 4F 69 DA CF'],
                ['01 50 B0 0C 43 37 32 39', # 3-8
                 '01 50 B0 0C 42 67 82 35',
                 '01 B0 ED 50 AE 62 73 36',
                 '01 B0 ED 50 AF D2 9E 66',
                 '01 ED 0C B0 A3 2E D5 D3',
                 '01 ED 0C B0 A2 C3 D9 63',
                 '01 0C 50 ED F2 34 6B C2',  
                 '01 0C 50 ED F3 38 3B 2F']]]

# Multiply 8x8 matrices
def mult_Matrix_8x8 (A, B):
    A = np.matrix(A)
    B = np.matrix(B)
    return (A*B).tolist()

# Invert 8x8 matrices
def invert_Matrix_8x8 (A):
    A = np.matrix(A)
    return (A.I).tolist()

# Sanitize inverted 8x8 matrices for GF(2)
def sanitize_Matrix_8x8 (A):
    for i in range(8):
        for j in range(8):
            if A[i][j] < 0:
                A[i][j] = -A[i][j]
    normalize3 = 0;
    normalize5 = 0;
    for i in range(8):
        for j in range(8):
            if A[i][j] > 0.33 and A[i][j] < 0.34:
                normalize3 = 1
            if A[i][j] > 0.66 and A[i][j] < 0.67:
                normalize3 = 1
            if A[i][j] == 0.2 or A[i][j] == 0.4 or A[i][j] == 0.6 or A[i][j] == 0.8 or A[i][j] == 1.2:
                normalize5 = 1
            if A[i][j] < 0.1:
                A[i][j] = 0
    if normalize3 == 1:
        for i in range(8):
            for j in range(8):
                A[i][j] = round(A[i][j] * 3)
    if normalize5 == 1:
        for i in range(8):
            for j in range(8):
                A[i][j] = round(A[i][j] * 5)
    return A

# Convert 8x8 matrices to GF(2) by taking modulo 2 of all elements
def mod2_Matrix_8x8 (A):
    for i in range(8):
        for j in range(8):
            A[i][j] = int(round(A[i][j]))
    for i in range(8):
        for j in range(8):
            A[i][j] = A[i][j] % 2
    return A

# Convert hex char to list of 4 bits
def convert_Char2Bits (HEX):
    return{
            '0' :   [0, 0, 0, 0],
            '1' :   [0, 0, 0, 1],
            '2' :   [0, 0, 1, 0],
            '3' :   [0, 0, 1, 1],
            '4' :   [0, 1, 0, 0],
            '5' :   [0, 1, 0, 1],
            '6' :   [0, 1, 1, 0],
            '7' :   [0, 1, 1, 1],
            '8' :   [1, 0, 0, 0],
            '9' :   [1, 0, 0, 1],
            'A' :   [1, 0, 1, 0],
            'B' :   [1, 0, 1, 1],
            'C' :   [1, 1, 0, 0],
            'D' :   [1, 1, 0, 1],
            'E' :   [1, 1, 1, 0],
            'F' :   [1, 1, 1, 1],
            }[HEX]

# Convert hex string to list of bits
def convert_String2Bits (HEX):
    N = len(HEX)
    Bits = [0] * (4*N)
    Char2Bits = [0] * 4
    for i in range(N):
        Char2Bits = convert_Char2Bits(HEX[i])
        for j in range (4):
            Bits[(4*i) + j] = Char2Bits[j]
    return Bits

# Get 8x8 GF(2) matrix from string of space-separated hex columns
def convert_String2Matrix_8x8 (S):
    M = [[0] * 8] * 8
    for i in range(8):
        M[7 - i] = convert_String2Bits(str(S[(3*i)]) + str(S[(3*i) + 1]))
    M = zip(*M)
    return M

# Print 8x8 matrix
def print_Matrix_8x8 (M):
    for i in range(8):
        for j in range(8):
            print M[i][j]," ",
        print ""
    print ""

Affine = [[1, 1, 1, 1, 1, 0, 0, 0],
	      [0, 1, 1, 1, 1, 1, 0, 0],
	      [0, 0, 1, 1, 1, 1, 1, 0],
	      [0, 0, 0, 1, 1, 1, 1, 1],
	      [1, 0, 0, 0, 1, 1, 1, 1],
	      [1, 1, 0, 0, 0, 1, 1, 1],
	      [1, 1, 1, 0, 0, 0, 1, 1],
	      [1, 1, 1, 1, 0, 0, 0, 1]]
               
# Generate Verilog RTL for S-Boxes
def gen_GF_2_4_SBox_RTL_PolyBases ():
    print "Creating Design Verilog file ... ",
    target = open("./AES_SBox_GF_2_4_PolyBases.v", 'w')
    target.truncate()
    target.write("/*****************************************************\n")
    target.write("*       _________        __________               \n")
    target.write("*      /   _____/        \______   \ _______  ___ \n")
    target.write("*      \_____  \   ______ |    |  _//  _ \  \/  / \n")
    target.write("*      /        \ /_____/ |    |   (  <_> >    <  \n")
    target.write("*     /_______  /         |______  /\____/__/\_ \ \n")
    target.write("*             \/                 \/            \/ \n")
    target.write("*\n")
    target.write("*****************************************************/\n")
    target.write("\n/*****************************************************\n")
    target.write("* Last Modified: Utsav Banerjee (25th June 2023)\n")
    target.write("*****************************************************/\n\n\n")
    target.write("\n/*****************************************************\n")
    target.write("*\n* Auto-Generated using gen_GF_2_4_SBox_RTL_PolyBases\n*\n")
    target.write("* in -> map -> inverse -> inv_map + affine -> out\n*\n")
    target.write("*****************************************************/\n")

    target.write("\n/*****************************************************\n")
    target.write("* Affine Matrix:\n*\n")
    for ii in range(8):
        target.write("*\t")
        for jj in range(8):
            target.write(str(Affine[ii][jj]) + " ")
        target.write("\n")
    target.write("*****************************************************/\n")

    for i in range(3):  # Base GF(2^4) polynomials
        for j in range(8):  # Extension GF((2^4)^2) polynomials
            for k in range(8):  # 8 distinct mappings
                target.write("\n\n\n/*****************************************************\n")
                target.write("* S-Box # " + str(i+1) + " - " + str(j+1) + " - " + str(k+1) + "\n*\n")
                target.write("* GF(2^8): x^8 + x^4 + x^3 + x + 1\n")
                target.write("* GF(2^4): " + list_poly_base[i] + "\n")
                target.write("* GF((2^4)^2): " + list_poly_ext[i][j] + "\n")
                target.write("*\n* Mapping & Inverse Mapping:\n*\n")
                S = list_invmap[i][j][k]
                M_inv = convert_String2Matrix_8x8(S)
                M = invert_Matrix_8x8(M_inv)
                M = sanitize_Matrix_8x8(M)
                M = mod2_Matrix_8x8(M)
                for ii in range(8):
                    target.write("*\t")
                    for jj in range(8):
                        target.write(str(M[ii][jj]) + " ")
                    target.write("\t")
                    for jj in range(8):
                        target.write(str(M_inv[ii][jj]) + " ")
                    target.write("\n")
                target.write("*****************************************************/\n\n")
                target.write("module AES_SBox_GF_2_4_PolyBasis_" + str(i+1) + "_" + str(j+1) + "_" + str(k+1) + " (out, in);\n")
                target.write("\n\tinput [7:0] in;\n\toutput [7:0] out;\n")
                target.write("\n\twire [3:0] inH, inL, inH2, inH2E, inL2_add_inHL, ")
                target.write("inH_add_inL, outH, outL, d, d_inv;\n")
                
                target.write("\n\t// Mapping from GF(2^8) to GF((2^4)^2)\n")
                for ii in range(4):
                    target.write("\n\tassign inH[" + str(3-ii) + "] = ")
                    expr = ""
                    for jj in range(8):
                        if M[ii][jj] == 1:
                            expr = expr + "in[" + str(7-jj) + "] ^ "
                    expr = expr.rstrip(' ^ ')
                    expr = expr + ";"
                    target.write(expr)
                for ii in range(4):
                    target.write("\n\tassign inL[" + str(3-ii) + "] = ")
                    expr = ""
                    for jj in range(8):
                        if M[4+ii][jj] == 1:
                            expr = expr + "in[" + str(7-jj) + "] ^ "
                    expr = expr.rstrip(' ^ ')
                    expr = expr + ";"
                    target.write(expr)
                
                target.write("\n\n\t// GF((2^4)^2) Inverter with LUT-Based GF(2^4) Inverter\n")
                target.write("\n\tGF_2_4_Sqr" + str(i+1) + " u_sqr_H (.q(inH2), .a(inH));")
                target.write("\n\tGF_2_4_Mul" + str(i+1) + " u_mul_constE (.q(inH2E), .a(inH2), .b(4'h" + list_poly_ext_norms[i][j] + "));")
                target.write("\n\tassign inH_add_inL = inH ^ inL;")
                target.write("\n\tGF_2_4_Mul" + str(i+1) + " u_mul_H_L (.q(inL2_add_inHL), .a(inH_add_inL), .b(inL));")
                target.write("\n\tassign d = inH2E ^ inL2_add_inHL;")
                target.write("\n\tGF_2_4_Inv" + str(i+1) + "_LUT u_inv (.out(d_inv), .in(d));")
                target.write("\n\tGF_2_4_Mul" + str(i+1) + " u_mul_H_di (.q(outH), .a(inH), .b(d_inv));")
                target.write("\n\tGF_2_4_Mul" + str(i+1) + " u_mul_H_L_di (.q(outL), .a(inH_add_inL), .b(d_inv));")

                M_inv = mult_Matrix_8x8(Affine, M_inv)
                M_inv = mod2_Matrix_8x8(M_inv)
                target.write("\n\n\t/*****************************************************\n")
                target.write("\t* Inverse Map + Affine Matrix:\n\t*\n")
                for ii in range(8):
                    target.write("\t*\t")
                    for jj in range(8):
                        target.write(str(M_inv[ii][jj]) + " ")
                    target.write("\n")
                target.write("\t*****************************************************/")

                target.write("\n\n\t// Mapping from GF((2^4)^2) to GF(2^8) Combined with Affine Transformation\n")
                for ii in range(8):
                    target.write("\n\tassign out[" + str(7-ii) + "] = ")
                    expr = ""
                    for jj in range(4):
                        if M_inv[ii][jj] == 1:
                            expr = expr + "outH[" + str(3-jj) + "] ^ "
                    for jj in range(4):
                        if M_inv[ii][4+jj] == 1:
                            expr = expr + "outL[" + str(3-jj) + "] ^ "
                    expr = expr.rstrip(' ^ ')
                    if ii == 1 or ii == 2 or ii == 6 or ii == 7:
                        expr = "~( " + expr + " )"
                    expr = expr + ";"
                    target.write(expr)

                target.write("\n\nendmodule\n\n\n")

    target.write("\n\n\n/************************************\n")
    target.write("*\n* Wrapper for all 192 S-Boxes\n*\n")
    target.write("************************************/\n\n")

    target.write("module AES_SBox_GF_2_4_AllPolyBases (\n\t\t\t\t\t")
    for i in range(3):
        for j in range(8):
            for k in range(8):
                target.write("out_" + str(i+1) + "_" + str(j+1) + "_" + str(k+1) + ", ")
            target.write("\n\t\t\t\t\t")
    target.write("in   );\n")

    target.write("\n\tinput [7:0] in;\n")
    for i in range(3):
        for j in range(8):
            for k in range(8):
                target.write("\n\toutput [7:0] out_" + str(i+1) + "_" + str(j+1) + "_" + str(k+1) + ";")
    target.write("\n")

    for i in range(3):
        for j in range(8):
            for k in range(8):
                target.write("\n\tAES_SBox_GF_2_4_PolyBasis_" + str(i+1) + "_" + str(j+1) + "_" + str(k+1))
                target.write(" u_sbox_" + str(i+1) + "_" + str(j+1) + "_" + str(k+1))
                target.write(" (.out(out_" + str(i+1) + "_" + str(j+1) + "_" + str(k+1) + "), .in(in));")

    target.write("\n\nendmodule\n\n")

    target.write("\n\n\n/************************************")
    target.write("\n* END OF FILE")
    target.write("\n************************************/\n\n\n")
    target.close()
    print "OK\n"

gen_GF_2_4_SBox_RTL_PolyBases()
