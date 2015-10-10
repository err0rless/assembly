.data

string:
	.string "strchr word\n"

not_found:
	.string "strchr not found\n"

.text
	.global main
	.global strchr
	.include "header.s"

strchr:
	push %ebp
	mov  %esp, %ebp
	push %esi
	push %ebx

	mov  0x08(%ebp), %esi
	movb 0x0C(%ebp), %bl

.strchr_loop:
	cmpb (%esi), %bl  # chr
	je   .strchr_true

	cmpb $0x00, (%esi)# null byte
	je   .strchr_false

	inc  %esi
	jmp  .strchr_loop

.strchr_false:
	mov $-0x01, %eax  # return -1
	jmp .strchr_final

.strchr_true:
	mov %esi, %eax    # return string

.strchr_final:
	pop %ebx
	pop %esi
	leave
	ret

main:
	push %ebp
	mov  %esp, %ebp

	push $0x72   # r
	push $string
	call strchr

	cmp  $-0x01, %eax
	je   .not_found

	push %eax
	call puts
	
	jmp  .exit

.not_found:
	push $not_found
	call strlen

	push %eax
	push $not_found
	push $0x01
	call write

.exit:
	push $0x00
	call exit

	leave
	ret
