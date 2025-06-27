section .text
global index
index:
	; rdi: matrix
	; rsi: rows
	; rdx: cols
	; rcx: rindex
	; r8: cindex

	; Matrix index formula: M[i][j] = base_address + (i * num_columns + j) * element_size
	
	; i * num_columns
	mov rax, rcx
	imul rax, rdx
	
	; (i * num_columns) + j
	add rax, r8
	
	; (i * num_columns + j) * element_size
	imul rax, 4 ; Multiply by 4 (size of int)

	; Add base address (matrix) -- base_address + (i * num_columns + j) * element_size
	add rax, rdi
	
	; Load the value from calculated address
	mov eax, [rax] ; Load 32-bit integer from memory
	ret

