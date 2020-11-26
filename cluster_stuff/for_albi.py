import numpy as np

def main(INPUT):
    B, N = INPUT.shape
    M = np.max(INPUT)
    OUT = np.zeros((B,N,M))
    for i, vect in enumerate(INPUT):
        for j, e in enumerate(vect):
            if e != 0:
                OUT[i][j][e-1] = 1
    return OUT

if __name__=='__main__':
    INPUT = np.array([[1,2,3],[9,8,7],[4,5,8]])
    out = main(INPUT)
    print(out)
