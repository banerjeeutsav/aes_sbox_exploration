#! /usr/local/bin/python

#=====================================================
# Last Modified: Utsav Banerjee (25th June 2023)
#=====================================================

import os, binascii
import numpy as np

#=====================================================
#
# Auto-Generate Verilog for 432 S-Box Designs
#
# Ref: Canright, "A Very Compact Rijndael S-Box," 2004
#
#=====================================================

def get_GF_2_2_Sum (A, B):
    if A == '0' and B == '0':
        return '0'
    elif A == '0' and B == '1':
        return '1'
    elif A == '0' and B == 'N':
        return 'N'
    elif A == '0' and B == 'N2':
        return 'N2'
    elif A == '1' and B == '0':
        return '1'
    elif A == '1' and B == '1':
        return '0'
    elif A == '1' and B == 'N':
        return 'N2'
    elif A == '1' and B == 'N2':
        return 'N'
    elif A == 'N' and B == '0':
        return 'N'
    elif A == 'N' and B == '1':
        return 'N2'
    elif A == 'N' and B == 'N':
        return '0'
    elif A == 'N' and B == 'N2':
        return '1'
    elif A == 'N2' and B == '0':
        return 'N2'
    elif A == 'N2' and B == '1':
        return 'N'
    elif A == 'N2' and B == 'N':
        return '1'
    elif A == 'N2' and B == 'N2':
        return '0'
    else:
        return 'ERROR'

def get_GF_2_2_Prod (A, B):
    if A == '0' and B == '0':
        return '0'
    elif A == '0' and B == '1':
        return '0'
    elif A == '0' and B == 'N':
        return '0'
    elif A == '0' and B == 'N2':
        return '0'
    elif A == '1' and B == '0':
        return '0'
    elif A == '1' and B == '1':
        return '1'
    elif A == '1' and B == 'N':
        return 'N'
    elif A == '1' and B == 'N2':
        return 'N2'
    elif A == 'N' and B == '0':
        return '0'
    elif A == 'N' and B == '1':
        return 'N'
    elif A == 'N' and B == 'N':
        return 'N2'
    elif A == 'N' and B == 'N2':
        return '1'
    elif A == 'N2' and B == '0':
        return '0'
    elif A == 'N2' and B == '1':
        return 'N2'
    elif A == 'N2' and B == 'N':
        return '1'
    elif A == 'N2' and B == 'N2':
        return 'N'
    else:
        return 'ERROR'

# Auto-Generate Verilog for 16 GF(2^4) Squarer-Scalers in Polynomial Basis
# n = Cz + D
# C \in {N, N2}
# D \in {0, 1, N, N2}
# N \in {w, w2}

def gen_GF_2_4_SQR_SCL_Poly ():
    N = ['w', 'w2']
    C = ['N', 'N2']
    D = ['0', '1', 'N', 'N2']

    print "// Optimized GF(2^4) Squarer-Scalers for Polynomial Basis"
    print "// Auto-Generated using gen_GF_2_4_SQR_SCL_Poly"
    for i in range(2):  # Iterate over C values
        for j in range(4):  # Iterate over D values
            for k in range(2):  # Iterate over N values
                print "\n// Polynomial Basis GF(2^4) Squarer-(%s,%s)-Scaler with N = %s\n" % (C[i], D[j], N[k])
                print "module GF_2_4_SQR_SCL_%s_%s_N%s_Poly (q, a);\n" % (C[i], D[j], N[k])
                print "\tinput\t[3:0]\ta;\n\n\toutput\t[3:0]\tq;\n"
                print "\twire\t[1:0]\tt00, t01, t10, t11;\n"

                T00 = D[j]
                T10 = C[i]
                C_plus_D = get_GF_2_2_Sum(C[i], D[j])
                T01 = get_GF_2_2_Prod(C_plus_D, 'N')
                C_dot_N2 = get_GF_2_2_Prod(C[i], 'N2')
                T11 = get_GF_2_2_Sum(C_dot_N2, D[j])
                
                # OUT[1] = (C)*(IN[0]^2) + (C*N2 + D)*(IN[1]^2)
                # OUT[0] = (D)*(IN[0]^2) + ((C + D)*N)*(IN[1]^2)
                
                if T10 == 'N':
                    print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));\n" % (N[k])
                else:
                    print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_10 (.q(t10), .a(a[1:0]));\n" % (N[1-k])

                if T00 == T10:
                    print "\tassign t00 = t10;\n"
                else:
                    if T00 == '0':
                        print "\tassign t00 = 2'b00;\n"
                    elif T00 == '1':
                        print "\tGF_2_2_SQR_Poly u_sqr_00 (.q(t00), .a(a[1:0]));\n"
                    elif T00 == 'N':
                        print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));\n" % (N[k])
                    else:
                        print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_00 (.q(t00), .a(a[1:0]));\n" % (N[1-k])

                if T11 == '0':
                    print "\tassign t11 = 2'b00;\n"
                elif T11 == '1':
                    print "\tGF_2_2_SQR_Poly u_sqr_11 (.q(t11), .a(a[3:2]));\n"
                elif T11 == 'N':
                    print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));\n" % (N[k])
                else:
                    print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_11 (.q(t11), .a(a[3:2]));\n" % (N[1-k])
                
                if T01 == T11:
                    print "\tassign t01 = t11;\n"
                else:
                    if T01 =='0':
                        print "\tassign t01 = 2'b00;\n"
                    elif T01 == '1':
                        print "\tGF_2_2_SQR_Poly u_sqr_01 (.q(t01), .a(a[3:2]));\n"
                    elif T01 == 'N':
                        print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));\n" % (N[k])
                    else:
                        print "\tGF_2_2_SQR_SCL%s_Poly u_sqr_scl_01 (.q(t01), .a(a[3:2]));\n" % (N[1-k])
                
                print "\tassign q = {(t10 ^ t11), (t00 ^ t01)};\n"
                print "endmodule"

# Auto-Generate Verilog for 16 GF(2^4) Squarer-Scalers in Normal Basis
# n = Cz^4 + Dz
# C \in {0, 1, N, N2}
# D \in {0, 1, N, N2}
# N \in {w, w2}

def gen_GF_2_4_SQR_SCL_Norm ():
    N = ['w', 'w2']
    C = ['0', '1', 'N', 'N2']
    D = ['0', '1', 'N', 'N2']

    print "// Optimized GF(2^4) Squarer-Scalers for Normal Basis"
    print "// Auto-Generated using gen_GF_2_4_SQR_SCL_Norm"
    for i in range(4):  # Iterate over C values
        for j in range(4):  # Iterate over D values
            for k in range(2):  # Iterate over N values
                print "\n// Normal Basis GF(2^4) Squarer-(%s,%s)-Scaler with N = %s\n" % (C[i], D[j], N[k])
                print "module GF_2_4_SQR_SCL_%s_%s_N%s_Norm (q, a);\n" % (C[i], D[j], N[k])
                print "\tinput\t[3:0]\ta;\n\n\toutput\t[3:0]\tq;\n"
                print "\twire\t[1:0]\tt00, t01, t10, t11;\n"

                C_dot_N = get_GF_2_2_Prod(C[i], 'N')
                D_dot_N = get_GF_2_2_Prod(D[j], 'N')
                T10 = D_dot_N
                T01 = C_dot_N
                T11 = get_GF_2_2_Sum(D_dot_N, C[i])
                T00 = get_GF_2_2_Sum(C_dot_N, D[j])

                # OUT[1] = (ND)*(IN[0]^2) + (C + ND)*(IN[1]^2)
                # OUT[0] = (D + NC)*(IN[0]^2) + (NC)*(IN[1]^2)
                
                if T10 == '0':
                    print "\tassign t10 = 2'b00;\n"
                elif T10 == '1':
                    print "\tGF_2_2_SQR_Norm u_sqr_10 (.q(t10), .a(a[1:0]));\n"
                elif T10 == 'N':
                    print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));\n" % (N[k])
                else:
                    print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_10 (.q(t10), .a(a[1:0]));\n" % (N[1-k])

                if T00 == T10:
                    print "\tassign t00 = t10;\n"
                else:
                    if T00 == '0':
                        print "\tassign t00 = 2'b00;\n"
                    elif T00 == '1':
                        print "\tGF_2_2_SQR_Norm u_sqr_00 (.q(t00), .a(a[1:0]));\n"
                    elif T00 == 'N':
                        print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));\n" % (N[k])
                    else:
                        print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_00 (.q(t00), .a(a[1:0]));\n" % (N[1-k])

                if T11 == '0':
                    print "\tassign t11 = 2'b00;\n"
                elif T11 == '1':
                    print "\tGF_2_2_SQR_Norm u_sqr_11 (.q(t11), .a(a[3:2]));\n"
                elif T11 == 'N':
                    print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));\n" % (N[k])
                else:
                    print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_11 (.q(t11), .a(a[3:2]));\n" % (N[1-k])
                
                if T01 == T11:
                    print "\tassign t01 = t11;\n"
                else:
                    if T01 =='0':
                        print "\tassign t01 = 2'b00;\n"
                    elif T01 == '1':
                        print "\tGF_2_2_SQR_Norm u_sqr_01 (.q(t01), .a(a[3:2]));\n"
                    elif T01 == 'N':
                        print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));\n" % (N[k])
                    else:
                        print "\tGF_2_2_SQR_SCL%s_Norm u_sqr_scl_01 (.q(t01), .a(a[3:2]));\n" % (N[1-k])
                
                print "\tassign q = {(t10 ^ t11), (t00 ^ t01)};\n"
                print "endmodule"

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
    normalize7 = 0;
    normalize9 = 0;
    normalize15 = 0;
    for i in range(8):
        for j in range(8):
            if A[i][j] > 0.33 and A[i][j] < 0.34:
                normalize3 = 1
            if A[i][j] > 0.66 and A[i][j] < 0.67:
                normalize3 = 1
            if A[i][j] > 1.33 and A[i][j] < 1.34:
                normalize3 = 1
            if A[i][j] > 1.66 and A[i][j] < 1.67:
                normalize3 = 1
            if A[i][j] > 2.33 and A[i][j] < 2.34:
                normalize3 = 1
            if A[i][j] > 2.66 and A[i][j] < 2.67:
                normalize3 = 1
            if A[i][j] == 0.2 or A[i][j] == 0.4 or A[i][j] == 0.6 or A[i][j] == 0.8 or A[i][j] == 1.2 or A[i][j] == 1.4 or A[i][j] == 1.6 or A[i][j] == 1.8:
                normalize5 = 1
            if A[i][j] > 0.142857 and A[i][j] < 0.142858:
                normalize7 = 1
            if A[i][j] > 0.285714 and A[i][j] < 0.285715:
                normalize7 = 1
            if A[i][j] > 0.428571 and A[i][j] < 0.428572:
                normalize7 = 1
            if A[i][j] > 0.571428 and A[i][j] < 0.571429:
                normalize7 = 1
            if A[i][j] > 0.714285 and A[i][j] < 0.714286:
                normalize7 = 1
            if A[i][j] > 0.857142 and A[i][j] < 0.857143:
                normalize7 = 1
            if A[i][j] > 1.142857 and A[i][j] < 1.142858:
                normalize7 = 1
            if A[i][j] > 1.142857 and A[i][j] < 1.142858:
                normalize7 = 1
            if A[i][j] > 1.285714 and A[i][j] < 1.285715:
                normalize7 = 1
            if A[i][j] > 1.428571 and A[i][j] < 1.428572:
                normalize7 = 1
            if A[i][j] > 1.571428 and A[i][j] < 1.571429:
                normalize7 = 1
            if A[i][j] > 1.714285 and A[i][j] < 1.714286:
                normalize7 = 1
            if A[i][j] > 1.857142 and A[i][j] < 1.857143:
                normalize7 = 1
            if A[i][j] > 0.11 and A[i][j] < 0.12:
                normalize9 = 1
            if A[i][j] > 0.22 and A[i][j] < 0.23:
                normalize9 = 1
            if A[i][j] > 0.44 and A[i][j] < 0.45:
                normalize9 = 1
            if A[i][j] > 0.55 and A[i][j] < 0.56:
                normalize9 = 1
            if A[i][j] > 0.77 and A[i][j] < 0.78:
                normalize9 = 1
            if A[i][j] > 0.88 and A[i][j] < 0.89:
                normalize9 = 1
            if A[i][j] > 1.11 and A[i][j] < 1.12:
                normalize9 = 1
            if A[i][j] > 0.066 and A[i][j] < 0.067:
                normalize15 = 1
            if A[i][j] > 0.133 and A[i][j] < 0.134:
                normalize15 = 1
            if A[i][j] > 0.266 and A[i][j] < 0.267:
                normalize15 = 1
            if A[i][j] > 0.466 and A[i][j] < 0.467:
                normalize15 = 1
            if A[i][j] > 0.533 and A[i][j] < 0.534:
                normalize15 = 1
            if A[i][j] > 0.733 and A[i][j] < 0.734:
                normalize15 = 1
            if A[i][j] > 0.866 and A[i][j] < 0.867:
                normalize15 = 1
            if A[i][j] > 0.933 and A[i][j] < 0.934:
                normalize15 = 1
            if A[i][j] < 0.001:
                A[i][j] = 0
    #if (normalize3+normalize5+normalize7+normalize15) > 1:
    #    print "NORM ERROR Detected"
    if normalize3 == 1 and normalize9 == 1:
        normalize3 = 0
        normalize9 = 1
    #    print "NORM ERROR Corrected"
    if normalize3 == 1 and normalize5 == 1 and normalize15 == 1:
        normalize3 = 0
        normalize5 = 0
        normalize15 = 1
    #    print "NORM ERROR Corrected"
    if normalize3 == 1:
        for i in range(8):
            for j in range(8):
                A[i][j] = round(A[i][j] * 3)
    if normalize5 == 1:
        for i in range(8):
            for j in range(8):
                A[i][j] = round(A[i][j] * 5)
    if normalize7 == 1:
        for i in range(8):
            for j in range(8):
                A[i][j] = round(A[i][j] * 7)
    if normalize9 == 1:
        for i in range(8):
            for j in range(8):
                A[i][j] = round(A[i][j] * 9)
    if normalize15 == 1:
        for i in range(8):
            for j in range(8):
                A[i][j] = round(A[i][j] * 15)
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

powB = ['01', '03', '05', '0F', '11', '33', '55', 'FF', '1A', '2E', '72', '96', 'A1', 'F8', '13', '35',
        '5F', 'E1', '38', '48', 'D8', '73', '95', 'A4', 'F7', '02', '06', '0A', '1E', '22', '66', 'AA',
        'E5', '34', '5C', 'E4', '37', '59', 'EB', '26', '6A', 'BE', 'D9', '70', '90', 'AB', 'E6', '31',
        '53', 'F5', '04', '0C', '14', '3C', '44', 'CC', '4F', 'D1', '68', 'B8', 'D3', '6E', 'B2', 'CD',
        '4C', 'D4', '67', 'A9', 'E0', '3B', '4D', 'D7', '62', 'A6', 'F1', '08', '18', '28', '78', '88',
        '83', '9E', 'B9', 'D0', '6B', 'BD', 'DC', '7F', '81', '98', 'B3', 'CE', '49', 'DB', '76', '9A',
        'B5', 'C4', '57', 'F9', '10', '30', '50', 'F0', '0B', '1D', '27', '69', 'BB', 'D6', '61', 'A3',
        'FE', '19', '2B', '7D', '87', '92', 'AD', 'EC', '2F', '71', '93', 'AE', 'E9', '20', '60', 'A0',
        'FB', '16', '3A', '4E', 'D2', '6D', 'B7', 'C2', '5D', 'E7', '32', '56', 'FA', '15', '3F', '41',
        'C3', '5E', 'E2', '3D', '47', 'C9', '40', 'C0', '5B', 'ED', '2C', '74', '9C', 'BF', 'DA', '75',
        '9F', 'BA', 'D5', '64', 'AC', 'EF', '2A', '7E', '82', '9D', 'BC', 'DF', '7A', '8E', '89', '80',
        '9B', 'B6', 'C1', '58', 'E8', '23', '65', 'AF', 'EA', '25', '6F', 'B1', 'C8', '43', 'C5', '54',
        'FC', '1F', '21', '63', 'A5', 'F4', '07', '09', '1B', '2D', '77', '99', 'B0', 'CB', '46', 'CA',
        '45', 'CF', '4A', 'DE', '79', '8B', '86', '91', 'A8', 'E3', '3E', '42', 'C6', '51', 'F3', '0E',
        '12', '36', '5A', 'EE', '29', '7B', '8D', '8C', '8F', '8A', '85', '94', 'A7', 'F2', '0D', '17',
        '39', '4B', 'DD', '7C', '84', '97', 'A2', 'FD', '1C', '24', '6C', 'B4', 'C7', '52', 'F6']

GF8_Bas = ['d', 'L']
GF4_Bas = 'alpha'
GF2_Bas = 'Omega'

logB = {'d': 7, 'L': 246, 'alpha': 17, 'Omega': 85}

GF8_Pwrs = [[16, 1],
            [32, 2],
            [64, 4],
            [128, 8],
            [1, 0],
            [16, 0],
            [2, 0],
            [32, 0],
            [4, 0],
            [64, 0],
            [8, 0],
            [128, 0]]
GF4_Pwrs = [[4, 1],
            [8, 2],
            [1, 0],
            [4, 0],
            [2, 0],
            [8, 0]]
GF2_Pwrs = [[2, 1],
            [1, 0],
            [2, 0]]

NVals = [['w', 'w', 'w2'],
         ['w2', 'w2', 'w'],
         ['w', 'w', 'w2'],
         ['w', 'w', 'w2'],
         ['w2', 'w2', 'w'],
         ['w2', 'w2', 'w']]

CVals_d = [['N2', '0', 'N', 'N', 'N2', 'N2'],
           ['N2', 'N2', 'N2', 'N2', 'N', 'N'],
           ['1', 'N2', 'N', 'N', 'N2', 'N2'],
           ['0', '1', 'N2', 'N2', 'N', 'N'],
           ['N2', '0', 'N', 'N', 'N2', 'N2'],
           ['N2', '0', 'N', 'N', 'N2', 'N2'],
           ['N2', 'N2', 'N2', 'N2', 'N', 'N'],
           ['N2', 'N2', 'N2', 'N2', 'N', 'N'],
           ['1', 'N2', 'N', 'N', 'N2', 'N2'],
           ['1', 'N2', 'N', 'N', 'N2', 'N2'],
           ['0', '1', 'N2', 'N2', 'N', 'N'],
           ['0', '1', 'N2', 'N2', 'N', 'N']]

CVals_L = [['0', 'N', 'N', 'N', 'N2', 'N2'],
           ['1', '0', 'N2', 'N2', 'N', 'N'],
           ['N', '1', 'N', 'N', 'N2', 'N2'],
           ['N', 'N', 'N2', 'N2', 'N', 'N'],
           ['0', 'N', 'N', 'N', 'N2', 'N2'],
           ['0', 'N', 'N', 'N', 'N2', 'N2'],
           ['1', '0', 'N2', 'N2', 'N', 'N'],
           ['1', '0', 'N2', 'N2', 'N', 'N'],
           ['N', '1', 'N', 'N', 'N2', 'N2'],
           ['N', '1', 'N', 'N', 'N2', 'N2'],
           ['N', 'N', 'N2', 'N2', 'N', 'N'],
           ['N', 'N', 'N2', 'N2', 'N', 'N']]

DVals_d = [['1', 'N2', 'N2', '1', '0', 'N2'],
           ['0', '1', 'N2', '0', 'N2', '1'],
           ['N2', '0', '1', 'N2', 'N2', '0'],
           ['N2', 'N2', '0', 'N2', '1', 'N2'],
           ['1', 'N2', 'N2', '1', '0', 'N2'],
           ['1', 'N2', 'N2', '1', '0', 'N2'],
           ['0', '1', 'N2', '0', 'N2', '1'],
           ['0', '1', 'N2', '0', 'N2', '1'],
           ['N2', '0', '1', 'N2', 'N2', '0'],
           ['N2', '0', '1', 'N2', 'N2', '0'],
           ['N2', 'N2', '0', 'N2', '1', 'N2'],
           ['N2', 'N2', '0', 'N2', '1', 'N2']]


DVals_L = [['N', '1', '0', 'N', 'N', '1'],
           ['N', 'N', '1', 'N', '0', 'N'],
           ['0', 'N', 'N', '0', '1', 'N'],
           ['1', '0', 'N', '1', 'N', '0'],
           ['N', '1', '0', 'N', 'N', '1'],
           ['N', '1', '0', 'N', 'N', '1'],
           ['N', 'N', '1', 'N', '0', 'N'],
           ['N', 'N', '1', 'N', '0', 'N'],
           ['0', 'N', 'N', '0', '1', 'N'],
           ['0', 'N', 'N', '0', '1', 'N'],
           ['1', '0', 'N', '1', 'N', '0'],
           ['1', '0', 'N', '1', 'N', '0']]

Affine = [[1, 1, 1, 1, 1, 0, 0, 0],
	      [0, 1, 1, 1, 1, 1, 0, 0],
	      [0, 0, 1, 1, 1, 1, 1, 0],
	      [0, 0, 0, 1, 1, 1, 1, 1],
	      [1, 0, 0, 0, 1, 1, 1, 1],
	      [1, 1, 0, 0, 0, 1, 1, 1],
	      [1, 1, 1, 0, 0, 0, 1, 1],
	      [1, 1, 1, 1, 0, 0, 0, 1]]

M = [[0] * 8 ] * 8
M_inv = [[0] * 8 ] * 8
               
# Generate Verilog RTL for S-Boxes
def gen_GF_2_2_2_SBox_RTL_PolyNormMixBases ():
    print "Creating Design Verilog file ... ",
    target = open("./AES_SBox_GF_2_2_2_PolyNormMixBases.v", 'w')
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
    target.write("*\n* Auto-Generated using gen_GF_2_2_2_SBox_RTL_PolyNormMixBases\n*\n")
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

    target.write("\n\n/*****************************************************\n")
    target.write("*\n* GF(2^8) in Normal Basis\n*\n")
    target.write("*****************************************************/\n")

    count = 0
    # GF(2^8) Normal Basis    
    for base in range(2):  # GF(2^8) Basis 'd' or Basis 'L'
        for i in range(4):
            for j in range(6):
                for k in range(3):
                    count = count + 1
                    #print(count)
                    # Determine types of Bases
                    if GF8_Pwrs[i][1] == 0:
                        GF8_Basis = 'Poly'
                    else:
                        GF8_Basis = 'Norm'
                    if GF4_Pwrs[j][1] == 0:
                        GF4_Basis = 'Poly'
                    else:
                        GF4_Basis = 'Norm'
                    if GF2_Pwrs[k][1] == 0:
                        GF2_Basis = 'Poly'
                    else:
                        GF2_Basis = 'Norm'
                    target.write("\n\n\n/*****************************************************\n")
                    target.write("* S-Box # " + str(count) + "\n*\n")
                    target.write("* GF(2^8) " + GF8_Basis + " Basis: [" + GF8_Bas[base] + "^" + str(GF8_Pwrs[i][0]) + ", ")
                    if GF8_Basis == 'Poly':
                        target.write("1]\n")
                    else:
                        target.write(GF8_Bas[base] + "^" + str(GF8_Pwrs[i][1]) + "]\n")
                    target.write("* GF(2^4) " + GF4_Basis + " Basis: [" + GF4_Bas + "^" + str(GF4_Pwrs[j][0]) + ", ")
                    if GF4_Basis == 'Poly':
                        target.write("1]\n")
                    else:
                        target.write(GF4_Bas + "^" + str(GF4_Pwrs[j][1]) + "]\n")
                    target.write("* GF(2^2) " + GF2_Basis + " Basis: [" + GF2_Bas + "^" + str(GF2_Pwrs[k][0]) + ", ")
                    if GF2_Basis == 'Poly':
                        target.write("1]\n")
                    else:
                        target.write(GF2_Bas + "^" + str(GF2_Pwrs[k][1]) + "]\n")
                    target.write("*\n* Mapping & Inverse Mapping:\n*\n")
                    
                    col7 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col6 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    col5 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col4 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    col3 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col2 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    col1 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col0 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    Scol7 = powB[col7]
                    Scol6 = powB[col6]
                    Scol5 = powB[col5]
                    Scol4 = powB[col4]
                    Scol3 = powB[col3]
                    Scol2 = powB[col2]
                    Scol1 = powB[col1]
                    Scol0 = powB[col0]
                    S = Scol0 + " " + Scol1 + " " + Scol2 + " " + Scol3 + " " + Scol4 + " " + Scol5 + " " + Scol6 + " " + Scol7
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
                    target.write("*\n* S = " + S + "\n")
                    target.write("*****************************************************/\n\n")
                    target.write("module AES_SBox_GF_2_2_2_PolyNormMixBasis_" + str(count) + " (out, in);\n")
                    target.write("\n\tinput [7:0] in;\n\toutput [7:0] out;\n")
                    target.write("\n\twire [7:0] g_in, g_out;\n")
                    target.write("\n\twire [3:0] t1, t2, t3, t4, t5, t6, t7;\n")

                    target.write("\n\t// Mapping from GF(2^8) to GF(((2^2)^2)^2)\n")
                    for ii in range(8):
                        target.write("\n\tassign g_in[" + str(7-ii) + "] = ")
                        expr = ""
                        for jj in range(8):
                            if M[ii][jj] == 1:
                                expr = expr + "in[" + str(7-jj) + "] ^ "
                        expr = expr.rstrip(' ^ ')
                        expr = expr + ";"
                        target.write(expr)

                    target.write("\n\n\t// GF(((2^2)^2)^2) Inverter\n")
                    N = NVals[j][k]
                    if base == 0:
                        C = CVals_d[i][j]
                        D = DVals_d[i][j]
                    else:
                        C = CVals_L[i][j]
                        D = DVals_L[i][j]
                    target.write("\n\tassign t1 = g_in[7:4] ^ g_in[3:0];")
                    target.write("\n\tGF_2_4_MUL_N" + N + "_" + GF4_Basis + GF2_Basis + " u_mul_1 (.q(t2), .a(g_in[7:4]), .b(g_in[3:0]));")
                    target.write("\n\tGF_2_4_SQR_SCL_" + C + "_" + D + "_N" + N + "_" + GF4_Basis + GF2_Basis + " u_sqr_scl (.q(t3), .a(t1));")
                    target.write("\n\tassign t4 = t2 ^ t3;")
                    target.write("\n\tGF_2_4_INV_N" + N + "_" + GF4_Basis + GF2_Basis + " u_inv (.q(t5), .a(t4));")
                    target.write("\n\tGF_2_4_MUL_N" + N + "_" + GF4_Basis + GF2_Basis + " u_mul_2 (.q(t6), .a(t5), .b(g_in[3:0]));")
                    target.write("\n\tGF_2_4_MUL_N" + N + "_" + GF4_Basis + GF2_Basis + " u_mul_3 (.q(t7), .a(t5), .b(g_in[7:4]));")
                    target.write("\n\tassign g_out = {t6, t7};")
                    
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
                        for jj in range(8):
                            if M_inv[ii][jj] == 1:
                                expr = expr + "g_out[" + str(7-jj) + "] ^ "
                        expr = expr.rstrip(' ^ ')
                        if ii == 1 or ii == 2 or ii == 6 or ii == 7:
                            expr = "~( " + expr + " )"
                        expr = expr + ";"
                        target.write(expr)

                    target.write("\n\nendmodule\n\n\n")

    target.write("\n\n/*****************************************************\n")
    target.write("*\n* GF(2^8) in Polynomial Basis\n*\n")
    target.write("*****************************************************/\n")

    # GF(2^8) Polynomial Basis    
    for base in range(2):  # GF(2^8) Basis 'd' or Basis 'L'
        for i in range(4,12):
            for j in range(6):
                for k in range(3):
                    count = count + 1
                    #print(count)
                    # Determine types of Bases
                    if GF8_Pwrs[i][1] == 0:
                        GF8_Basis = 'Poly'
                    else:
                        GF8_Basis = 'Norm'
                    if GF4_Pwrs[j][1] == 0:
                        GF4_Basis = 'Poly'
                    else:
                        GF4_Basis = 'Norm'
                    if GF2_Pwrs[k][1] == 0:
                        GF2_Basis = 'Poly'
                    else:
                        GF2_Basis = 'Norm'
                    target.write("\n\n\n/*****************************************************\n")
                    target.write("* S-Box # " + str(count) + "\n*\n")
                    target.write("* GF(2^8) " + GF8_Basis + " Basis: [" + GF8_Bas[base] + "^" + str(GF8_Pwrs[i][0]) + ", ")
                    if GF8_Basis == 'Poly':
                        target.write("1]\n")
                    else:
                        target.write(GF8_Bas[base] + "^" + str(GF8_Pwrs[i][1]) + "]\n")
                    target.write("* GF(2^4) " + GF4_Basis + " Basis: [" + GF4_Bas + "^" + str(GF4_Pwrs[j][0]) + ", ")
                    if GF4_Basis == 'Poly':
                        target.write("1]\n")
                    else:
                        target.write(GF4_Bas + "^" + str(GF4_Pwrs[j][1]) + "]\n")
                    target.write("* GF(2^2) " + GF2_Basis + " Basis: [" + GF2_Bas + "^" + str(GF2_Pwrs[k][0]) + ", ")
                    if GF2_Basis == 'Poly':
                        target.write("1]\n")
                    else:
                        target.write(GF2_Bas + "^" + str(GF2_Pwrs[k][1]) + "]\n")
                    target.write("*\n* Mapping & Inverse Mapping:\n*\n")
                    
                    col7 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col6 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    col5 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col4 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][0]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    col3 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col2 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][0]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    col1 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][0])) % 255)
                    col0 = (((logB[GF8_Bas[base]]*GF8_Pwrs[i][1]) + (logB[GF4_Bas]*GF4_Pwrs[j][1]) + (logB[GF2_Bas]*GF2_Pwrs[k][1])) % 255)
                    Scol7 = powB[col7]
                    Scol6 = powB[col6]
                    Scol5 = powB[col5]
                    Scol4 = powB[col4]
                    Scol3 = powB[col3]
                    Scol2 = powB[col2]
                    Scol1 = powB[col1]
                    Scol0 = powB[col0]
                    S = Scol0 + " " + Scol1 + " " + Scol2 + " " + Scol3 + " " + Scol4 + " " + Scol5 + " " + Scol6 + " " + Scol7
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
                    target.write("*\n* S = " + S + "\n")
                    target.write("*****************************************************/\n\n")
                    target.write("module AES_SBox_GF_2_2_2_PolyNormMixBasis_" + str(count) + " (out, in);\n")
                    target.write("\n\tinput [7:0] in;\n\toutput [7:0] out;\n")
                    target.write("\n\twire [7:0] g_in, g_out;\n")
                    target.write("\n\twire [3:0] t1, t2, t3, t4, t5, t6, t7;\n")

                    target.write("\n\t// Mapping from GF(2^8) to GF(((2^2)^2)^2)\n")
                    for ii in range(8):
                        target.write("\n\tassign g_in[" + str(7-ii) + "] = ")
                        expr = ""
                        for jj in range(8):
                            if M[ii][jj] == 1:
                                expr = expr + "in[" + str(7-jj) + "] ^ "
                        expr = expr.rstrip(' ^ ')
                        expr = expr + ";"
                        target.write(expr)

                    target.write("\n\n\t// GF(((2^2)^2)^2) Inverter\n")
                    N = NVals[j][k]
                    if base == 0:
                        C = CVals_d[i][j]
                        D = DVals_d[i][j]
                    else:
                        C = CVals_L[i][j]
                        D = DVals_L[i][j]
                    target.write("\n\tassign t1 = g_in[7:4] ^ g_in[3:0];")
                    target.write("\n\tGF_2_4_MUL_N" + N + "_" + GF4_Basis + GF2_Basis + " u_mul_1 (.q(t2), .a(t1), .b(g_in[3:0]));")
                    target.write("\n\tGF_2_4_SQR_SCL_" + C + "_" + D + "_N" + N + "_" + GF4_Basis + GF2_Basis + " u_sqr_scl (.q(t3), .a(g_in[7:4]));")
                    target.write("\n\tassign t4 = t2 ^ t3;")
                    target.write("\n\tGF_2_4_INV_N" + N + "_" + GF4_Basis + GF2_Basis + " u_inv (.q(t5), .a(t4));")
                    target.write("\n\tGF_2_4_MUL_N" + N + "_" + GF4_Basis + GF2_Basis + " u_mul_2 (.q(t6), .a(t5), .b(g_in[7:4]));")
                    target.write("\n\tGF_2_4_MUL_N" + N + "_" + GF4_Basis + GF2_Basis + " u_mul_3 (.q(t7), .a(t5), .b(t1));")
                    target.write("\n\tassign g_out = {t6, t7};")
                    
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
                        for jj in range(8):
                            if M_inv[ii][jj] == 1:
                                expr = expr + "g_out[" + str(7-jj) + "] ^ "
                        expr = expr.rstrip(' ^ ')
                        if ii == 1 or ii == 2 or ii == 6 or ii == 7:
                            expr = "~( " + expr + " )"
                        expr = expr + ";"
                        target.write(expr)

                    target.write("\n\nendmodule\n\n\n")

    target.write("\n\n\n/************************************\n")
    target.write("*\n* Wrapper for all 432 S-Boxes\n*\n")
    target.write("************************************/\n\n")

    count = 0
    target.write("module AES_SBox_GF_2_4_AllPolyBases (\n\t\t\t\t\t")
    for i in range(24):
        for j in range(6):
            for k in range(3):
                count = count + 1
                target.write("out_" + str(count) + ", ")
            target.write("\n\t\t\t\t\t")
    target.write("in   );\n")

    count = 0
    target.write("\n\tinput [7:0] in;\n")
    for i in range(24):
        for j in range(6):
            for k in range(3):
                count = count + 1
                target.write("\n\toutput [7:0] out_" + str(count) + ";")
    target.write("\n")

    count = 0
    for i in range(24):
        for j in range(6):
            for k in range(3):
                count = count + 1
                target.write("\n\tAES_SBox_GF_2_2_2_PolyNormMixBasis_" + str(count))
                target.write(" u_sbox_" + str(count))
                target.write(" (.out(out_" + str(count) + "), .in(in));")

    target.write("\n\nendmodule\n\n")

    target.write("\n\n\n/************************************")
    target.write("\n* END OF FILE")
    target.write("\n************************************/\n\n\n")
    target.close()
    print "OK\n"

# python gen_AES_SBox_GF_2_2_2_PolyNormMixBases.py > gen_GF_2_4_SQR_SCL_Poly.out
# gen_GF_2_4_SQR_SCL_Poly()

# python gen_AES_SBox_GF_2_2_2_PolyNormMixBases.py > gen_GF_2_4_SQR_SCL_Norm.out
# gen_GF_2_4_SQR_SCL_Norm()

# python gen_AES_SBox_GF_2_2_2_PolyNormMixBases.py
gen_GF_2_2_2_SBox_RTL_PolyNormMixBases()
