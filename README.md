# Matrix Element Access in Assembly

A low-level implementation of 2D matrix element access using x86-64 assembly language.

## Overview

This project demonstrates how to access elements in a 2D matrix stored in row-major order using assembly language. Given a matrix `M` and indices `i` (row) and `j` (column), the program retrieves the value at `M[i][j]`.

## Problem Statement

Arrays in memory are stored as contiguous blocks of data. For a 2D matrix like:

```
[[1, 2, 3],
 [4, 5, 6]]
```

The memory layout is: `[1, 2, 3, 4, 5, 6]`

To access `M[1][2]` (which should return `6`), we need to calculate the correct memory address using the formula:

```
address = base_address + (i × num_columns + j) × element_size
```

## Implementation

The assembly function implements the following algorithm:

1. **Calculate linear position**: `i × num_columns + j`
2. **Convert to byte offset**: `position × 4` (since integers are 4 bytes)
3. **Add base address**: `base_address + byte_offset`
4. **Load the value** from the calculated memory address

## Files

- `matrix_access.asm` - Main assembly implementation
- `tests.c` - C test program to verify functionality
- `Makefile` - Build configuration

## Function Signature

### System V ABI (Linux/Unix)

```assembly
index:
    ; Parameters:
    ; rdi - pointer to matrix (base address)
    ; rsi - number of rows (unused in calculation)
    ; rdx - number of columns
    ; rcx - row index (i)
    ; r8  - column index (j)
    ; Returns: value at M[i][j] in eax
```

### Windows x64 ABI

```assembly
index:
    ; Parameters:
    ; rcx - pointer to matrix (base address)
    ; rdx - number of rows (unused)
    ; r8  - number of columns
    ; r9  - row index (i)
    ; [rsp+40] - column index (j) on stack
    ; Returns: value at M[i][j] in eax
```

## Building and Running

### Linux/Unix (System V ABI)

```bash
# Assemble
nasm -f elf64 matrix_access.asm -o matrix_access.o

# Compile and link with test
gcc -o test test.c matrix_access.o

# Run
./test
```

### Windows (Microsoft x64 ABI)

```bash
# Assemble
nasm -f win64 matrix_access.asm -o matrix_access.obj

# Compile and link
gcc -o test.exe test.c matrix_access.obj

# Run
test.exe
```

## Example Usage

```c
#include <stdio.h>

extern int index(int* matrix, int rows, int cols, int row_idx, int col_idx);

int main() {
    int matrix[] = {1, 2, 3, 4, 5, 6}; // [[1,2,3], [4,5,6]]
    int rows = 2, cols = 3;

    int result = index(matrix, rows, cols, 1, 2);
    printf("M[1][2] = %d\n", result); // Output: M[1][2] = 6

    return 0;
}
```

## Key Concepts Demonstrated

- **Memory addressing arithmetic** in assembly
- **Row-major order** matrix storage
- **Calling conventions** (System V vs Windows x64)
- **Register usage** and parameter passing
- **Memory dereferencing** with square bracket notation

## Learning Objectives

- Understand how 2D arrays are represented in memory
- Learn x86-64 assembly programming basics
- Practice address calculation and pointer arithmetic
- Explore different calling conventions

## Notes

- Assumes 32-bit integers (4 bytes each)
- Uses zero-based indexing (computer science convention)
- No bounds checking implemented (assumes valid indices)
- Compatible with both Intel and AT&T assembly syntax examples

## References

- [x86-64 Assembly Language Programming](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
- [System V AMD64 ABI](https://gitlab.com/x86-psABIs/x86-64-ABI)
- [Microsoft x64 Calling Convention](https://docs.microsoft.com/en-us/cpp/build/x64-calling-convention)
