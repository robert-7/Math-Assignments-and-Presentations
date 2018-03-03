import math


def cden(x, y):
    return (y - x) ** (-1)


def c11(x, y):
    return (-1) * cden(x, y)


def c12(x, y):
    return 1 + x * cden(x, y)


def c21(x, y):
    return cden(x, y)


def c22(x, y):
    return (-1) * x * cden(x, y)


def aden(x, y):
    return (x - y) ** (-1)


def a11(x, y, n):
    return (x ** (n + 1) - y ** (n + 1)) * aden(x, y)


def a12(x, y, n):
    return ((y ** (n + 1)) * x - (x ** (n + 1)) * y) * aden(x, y)


def a21(x, y, n):
    return (x ** n - y ** n) * aden(x, y)


def a22(x, y, n):
    return ((y ** n) * x - (x ** n) * y) * aden(x, y)


def print_all():
    x = (1 - math.sqrt(5)) / 2
    y = (1 + math.sqrt(5)) / 2

    print("Lambdas")
    print("")
    print(x)
    print(y)
    print("")

    print("Matrix P-Inverse that I have")
    print("")
    print(c11(x, y))
    print(c12(x, y))
    print(c21(x, y))
    print(c22(x, y))
    print("")

    a11wolfram = (-1) / (math.sqrt(5))
    a12wolfram = (5 + math.sqrt(5)) / 10
    a21wolfram = 1 / (math.sqrt(5))
    a22wolfram = (5 - math.sqrt(5)) / 10

    print("Wolfram P-Inverse")
    print("")
    print(a11wolfram)
    print(a12wolfram)
    print(a21wolfram)
    print(a22wolfram)
    print("")

    print("Are they close enough? Outputs the distance between the values.")
    print("")
    print(c11(x, y) - a11wolfram)
    print(c12(x, y) - a12wolfram)
    print(c21(x, y) - a21wolfram)
    print(c22(x, y) - a22wolfram)
    print("")

    for n in range(5):
        print("Test Default: n=" + str(n))
        print("")
        print((x ** (n + 2) + y ** (n + 2)) / (y - x))
        print((x ** (n + 1) + y ** (n + 1)) / (y - x))
        print("")

    n = 10

    print("Final Matrix")
    print("")
    print(a11(x, y, n))
    print(a12(x, y, n))
    print(a21(x, y, n))
    print(a22(x, y, n))
    print("")

    print("Final Vector Not Simplified By Algebra")
    print("")
    print(a11(x, y, n) + a12(x, y, n))
    print(a21(x, y, n) + a22(x, y, n))
    print("")

    print("Final Vector Simplified By Algebra")
    print("")
    print((x ** (n + 2) + y ** (n + 2)) / (y - x))
    print((x ** (n + 1) + y ** (n + 1)) / (y - x))

    import numpy

    C = numpy.matrix([[1, 1], [1, 0]])
    y_0 = numpy.matrix([[1], [1]])
    print(str(C))
    print(str(C ** 10))
    print(str(numpy.dot((C ** 10), y_0)))


if __name__ == "__main__":
    print_all()
