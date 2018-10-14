.model flat,stdcall

include asm2.inc

.data
szTmfmt db "%d:%d:%d",0ah,0
szCheck db "CHCHCH",0

.data?
ts1 dq ?

.code
PrintNowTime proc C
	invoke _time64,0 ;64位返回值高位在edx,低位在eax
	lea ebx,ts1
	mov DWORD PTR[ebx],eax ;注意高低位顺序
	mov DWORD PTR[ebx+4],edx
	invoke _localtime64,addr ts1
	invoke printf,addr szTmfmt,(tm PTR[eax]).tm_hour,(tm PTR[eax]).tm_min,(tm PTR[eax]).tm_sec ;惊了……我随便这样写的居然可以，，，
	ret
PrintNowTime endp
end
