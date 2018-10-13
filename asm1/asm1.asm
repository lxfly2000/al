.386
.model flat,stdcall
option casemap:none
;>=VS2015需要
includelib legacy_stdio_definitions.lib
includelib ucrt.lib

printf proto C szFormat:DWORD ;...
scanf proto C szFormat:DWORD ;...

.data
szPrompt db "输出项数：",0
szFmt db " %d",0
szRf db 0ah,"返回值：%d",0
varfs dd 1
varft dd ?

.code
main:
	invoke printf,addr szPrompt
	push offset varft
	push offset szFmt
	call scanf
	pop eax
	pop eax
	call Fib
	push varft
	push offset szRf
	call printf
	pop eax
	pop eax
	ret

Fib:
	mov esi,varft
	xor ebx,ebx
	mov varft,0
	FibLoop:
		dec esi
		mov ebx,varft
		add ebx,varfs
		push ebx
		push offset szFmt
		call printf
		pop eax
		mov eax,varft
		mov varfs,eax
		pop varft
		cmp esi,0
		jg FibLoop
	ret

end main
