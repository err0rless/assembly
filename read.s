.text
	.global  main
	.include "h.s"

read:
	push %ebp
	mov  %esp, %ebp
	push %ebx
	push %ecx
	push %edx

	mov  0x08(%ebp), %ebx # fd
	mov  0x0C(%ebp), %ecx # buf
	mov  0x10(%ebp), %edx # len
	mov  $0x03, %eax
	int  $0x80

	mov  0x10(%ebp), %eax
	
	pop  %edx
	pop  %ecx
	pop  %ebx
	leave
	ret

main:
	push %ebp
	mov  %esp, %ebp
	sub  $0x10, %esp

	lea  -0x10(%ebp), %ebx

	push $0x10
	push %ebx
	push $0x00
	call read

	push %ebx
	call puts

	push $0x00
	call exit

	leave
	ret
