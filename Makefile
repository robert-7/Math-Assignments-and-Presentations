# This is a Makefile for building and cleaning LaTeX files

# Target for building LaTeX files
build:
	ci/build.sh

# Target for cleaning up intermediary LaTeX files
clean:
	find . -type f \( -name '*.aux' -o -name '*.log' -o -name '*.nav' -o -name '*.out' -o -name '*.snm' -o -name '*.toc' \) -delete

# By default, running 'make' will trigger the 'build' target
all: build

.PHONY: all clean test
