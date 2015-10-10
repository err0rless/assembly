# /root/assembly/h.s
.text
	.global write
	.global read
	.global exit
	.global strlen
	.global strchr
	.global strcpy
	.global puts

# ssize_t write(int fd, const void *buf, size_t count);
write:
	push %ebp
	mov  %esp, %ebp
	push %ebx
	push %ecx
	push %edx

	mov  0x08(%ebp), %ebx # fd
	mov  0x0C(%ebp), %ecx # buf
	mov  0x10(%ebp), %edx # count
	mov  $0x04, %eax      # system call
	int  $0x80

	mov  %edx, %eax

	pop  %edx
	pop  %ecx
	pop  %ebx
	leave
	ret




# ssize_t read (int fd, void *buf, size_t nbytes);
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



# void exit(int status);
exit:
	push %ebp
	mov  %esp, %ebp

	mov  0x08(%ebp), %ebx
	mov  $0x01, %eax
	int  $0x80



# size_t strlen(const char *str);
strlen:
	push %ebp
	mov  %esp, %ebp
	push %ebx
	push %ecx
	push %esi

	mov  0x08(%ebp), %esi # string
	mov  $0x00, %ecx      # counter

.strlen_loop:
	movb (%esi), %bl
	cmpb $0x00, %bl  # null byte
	je   .strlen_final

	inc  %esi
	inc  %ecx
	jmp  .strlen_loop

.strlen_final:
	mov  %ecx, %eax
	
	pop  %esi
	pop  %ecx
	pop  %ebx
	leave
	ret




# char *strchr(const char *str, int chr);
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





# char *strcpy(char *dest, const char *src);
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



# int puts(const char *str);
puts:
	push %ebp
	mov  %esp, %ebp
	push %ebx

	sub  $0x1, %esp

	mov  0x08(%ebp), %ebx

	push %ebx
	call strlen
	
	push %eax
	push %ebx
	push $0x01
	call write
	# write string
	
	lea  -0x1(%ebp), %eax
	movb $0x0a, (%eax)

	push $0x01
	push %eax
	push $0x01
	call write
	# write newline

	mov  $0x01, %eax # ret value

	add  $0x01, %esp
	pop  %ebx
	leave
	ret
