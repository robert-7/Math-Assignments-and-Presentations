#!/usr/bin/env python3
"""The modules provides some validation of the claims made in ../paper.tex."""
import math
import numpy


def c_denominator(x, y):
    """Returns the common denominator of the inverse of the eigenvector matrix."""
    return (y - x) ** (-1)


def a_denominator(x, y):
    """Returns the common denominator of the companion matrix."""
    return (x - y) ** (-1)


def calculated_p_inverse_matrix(lambda_1: float, lambda_2: float):
    """Returns the matrix as calculate in our paper."""
    p11 = (-1) * c_denominator(lambda_1, lambda_2)
    p12 =  (1) + lambda_1 * c_denominator(lambda_1, lambda_2)  # noqa: E222
    p21 =  (1) * c_denominator(lambda_1, lambda_2)             # noqa: E222
    p22 = (-1) * lambda_1 * c_denominator(lambda_1, lambda_2)
    matrix = numpy.array([
        [p11, p12],
        [p21, p22]
    ])
    return matrix


def wolfram_p_inverse_matrix():
    """Returns the matrix as shown in Wolfram Alpha."""
    matrix = numpy.array([
        [(-1) / (math.sqrt(5)), (5 + math.sqrt(5)) / 10],
        [  1  / (math.sqrt(5)), (5 - math.sqrt(5)) / 10]  # noqa: E201, E221
    ])
    return matrix


def matrices_close(matrix_1, matrix_2) -> None:
    """Returns True if and only if the matrixes are 'close enough'."""
    return numpy.allclose(matrix_1, matrix_2, atol=1e-9)


def print_first_n_values(lambda_1: float, lambda_2: float, n: int) -> None:
    """Prints the first n terms of the sequence."""
    for i in range(n + 1):
        phi_n = (lambda_1 ** (i + 1) + lambda_2 ** (i + 1)) / (lambda_2 - lambda_1)
        phi_n_rounded = numpy.round(phi_n)
        print(f"For n={i:2.0f}, the computation is {phi_n:10.7f} which is roughly {phi_n_rounded:2.0f}.")
    print()

    i = 10
    print("Final Matrix")
    a11 = (lambda_1 ** (i + 1) - lambda_2 ** (i + 1)) * a_denominator(lambda_1, lambda_2)
    a12 = ((lambda_2 ** (i + 1)) * lambda_1 - (lambda_1 ** (i + 1)) * lambda_2) * a_denominator(lambda_1, lambda_2)
    a21 = (lambda_1 ** i - lambda_2 ** i) * a_denominator(lambda_1, lambda_2)
    a22 = ((lambda_2 ** i) * lambda_1 - (lambda_1 ** i) * lambda_2) * a_denominator(lambda_1, lambda_2)
    a_matrix = numpy.array([
        [a11, a12],
        [a21, a22]
    ])
    print(a_matrix, end="\n\n")


if __name__ == "__main__":
    phi = (1 - math.sqrt(5)) / 2
    phi_conjugate = (1 + math.sqrt(5)) / 2
    print("Lambdas")
    print(f"phi  = {phi}")
    print(f"phi' =  {phi_conjugate}")
    print()

    calculated_p_inverse_matrix = calculated_p_inverse_matrix(phi, phi_conjugate)
    print("Matrix P-Inverse")
    print(calculated_p_inverse_matrix, end="\n\n")

    wolfram_p_inverse_matrix = wolfram_p_inverse_matrix()
    print("Wolfram P-Inverse")
    print(wolfram_p_inverse_matrix, end="\n\n")

    print("Are they equal or close enough?", end=" ")
    if matrices_close(calculated_p_inverse_matrix, wolfram_p_inverse_matrix):
        print("Yes")
    else:
        print("No")

    print_first_n_values(phi, phi_conjugate, 10)
