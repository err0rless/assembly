# print_hello.s

.data   # start data section

string:
	.string "Hello, My First Assemly World!!\n"

.text   # start text section
	.global main

my_write:
	push %ebp
	mov  %esp, %ebp

	mov  0x08(%ebp), %ebx # fd
	mov  0x0C(%ebp), %ecx # buf
	mov  0x10(%ebp), %edx # len
	mov  $0x04, %eax      # system call
	int  $0x80

	leave
	ret

my_exit:
	push %ebp
	mov  %esp, %ebp

	mov  0x08(%ebp), %ebx
	mov  $0x01, %eax
	int  $0x80

strlen:
	push %ebp
	mov  %esp, %ebp
	
	mov  0x08(%ebp), %esi # string
	mov  $0x00, %ecx      # counter

.loop:
	movb (%esi), %al
	cmpb $0x00, %al  # null byte
	je   .final

	inc  %esi
	inc  %ecx
	jmp  .loop

.final:
	mov  %ecx, %eax
	leave
	ret

main:
	push %ebp
	mov  %esp, %ebp
	
	push $string
	call strlen

	mov %eax, %edx

	push %edx     # count
	push $string  # buf
	push $0x01    # fd
	call my_write # call write

	push $0x00    # status
	call my_exit  # call exit

	leave
	ret
