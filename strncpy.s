.data

noargv_except:
	.string "Usage ./strncpy string"

.text
	.global  main
	.global  strncpy
	.include "header.s"

strncpy:
	push %ebp
	mov  %esp, %ebp
	push %ebx
	push %ecx
	push %edx
	push %esi
	push %edi

	mov  $0x00, %ecx # cnt = 0
	mov  0x08(%ebp), %edi
	mov  0x0C(%ebp), %esi
	mov  0x10(%ebp), %ebx

	mov  %edi, %edx # ret value
.strncpy_loop:
	cmp  %ecx, %ebx
	je   .strncpy_final

	cmpb $0x00, (%esi)
	je   .esiNull

	movb (%esi), %al
	movb %al, (%edi)

	inc  %esi
.tmp:
	inc  %edi
	inc  %ecx # cnt++

	jmp  .strncpy_loop

.strncpy_final:
	movb $0x00, (%edi)
	mov  %ebx, %eax

	pop %edi
	pop %esi
	pop %edx
	pop %ecx
	pop %ebx
	leave
	ret

.esiNull: # if strlen(src) < n ; fill the dest to null
	movb $0x00, (%edi)
	jmp  .tmp  

main:
	push %ebp
	mov  %esp, %ebp

	sub  $0x20, %esp
	lea  -0x20(%ebp), %ebx

	cmpb $0x01, 0x08(%ebp) # if argc == 1
	je   .noargv           #   print except

	mov  0x0C(%ebp), %eax
	add  $0x04, %eax
	mov  (%eax), %eax

	mov  %eax, %ecx

	push $0x20
	push %ecx
	push %ebx
	call strncpy

	push %ebx
	call puts

	jmp  .exit

.noargv:
	push $noargv_except
	call puts

.exit:
	push $0x00
	call exit
