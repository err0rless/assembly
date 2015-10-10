.data

string:
	.string "strcpy test string\n"

.text
	.global  main

strcpy:
        push %ebp
        mov  %esp, %ebp
        push %ebx
        push %esi
        push %edi

        mov  0x08(%ebp), %edi # dest
        mov  0x0C(%ebp), %esi # src

        mov  %edi, %ebx # ebx = ret value

.strcpy_loop:
        cmpb $0x00, (%esi)
        je   .strcpy_final

        movb (%esi), %al
        movb %al, (%edi)

        inc  %edi
        inc  %esi

        jmp  .strcpy_loop

.strcpy_final:
        movb $0x00, (%edi)
        mov  %ebx, %eax

        pop  %edi
        pop  %esi
        pop  %ebx
        leave
        ret

main:
	push %ebp
	mov  %esp, %ebp
	sub  $0x20, %esp
	lea  -0x20(%ebp), %ebx # dest

	push $string
	push %ebx
	call strcpy
	# strcpy

	push $string
	call strlen
	# eax = strlen($string)

	lea -0x20(%ebp), %ebx

	push %eax
	push %ebx
	push $0x01
	call write
	# write

	push $0x00
	call exit
	# exit
