.text
	.global  main
	.global  gets
	.include "header.s"

gets:
	push %ebp
	mov  %esp, %ebp
	push %ebx
	push %ecx

	sub  $0x1000, %esp

	lea -0x1000(%ebp), %ebx
	
	push $0x1000
	push %ebx
	push $0x00
	call read

	push $0x0a
	push %ebx
	call strchr

	movb $0x00, (%eax) # '\n' = '\0'
	
	mov  0x08(%ebp), %ecx

	push %ebx
	push %ecx
	call strcpy

	mov  %ecx, %eax # ret
	
	add  $0x1000, %esp
	pop  %ecx
	pop  %ebx
	leave
	ret

main:
	push %ebp
	mov  %esp, %ebp
	sub  $0x10, %esp

	lea  -0x10(%ebp), %ebx
	push %ebx
	call gets

	push %eax
	call puts

	leave
	ret
