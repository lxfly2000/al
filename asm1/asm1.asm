.386
.model flat,stdcall
option casemap:none
;>=VS2015需要
includelib legacy_stdio_definitions.lib
includelib ucrt.lib
include asm2.inc

printf proto C szFormat:DWORD,:VARARG
scanf proto C szFormat:DWORD,:VARARG

.data
szHello db "Hello!",0
szPrompt db "输出项数：",0
szFmt db " %d",0
szRf db 0ah,"返回值：%d",0
varfs dd 1
varft dd ?

.code
main:
	invoke Hello,addr szHello
	invoke printf,addr szPrompt
	invoke scanf,addr szFmt,addr varft
	call Fib
	invoke printf,addr szRf,varft
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
