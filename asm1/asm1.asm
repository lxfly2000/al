.386
.model flat,stdcall
option casemap:none
include asm2.inc

.data
szPrompt db "输出项数：",0
szFmt db " %d",0
szRf db "返回值：%d",0ah,0
szOfw db "溢出了。",0ah,0
varfs dd 1

.data?
varft dd ?

.code
main:
	invoke PrintNowTime
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
		mov eax,varft
		mov varfs,eax
		mov varft,ebx
		.if overflow?
			invoke printf,addr szOfw
			ret
		.endif
		invoke printf,addr szFmt,varft
		cmp esi,0
		jg FibLoop
	ret

end main
