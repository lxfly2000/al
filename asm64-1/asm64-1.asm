;https://www.pediy.com/kssd/pediy09/pediy09-602.htm
;ML64不支持高级语言特性
;参数存储位置：RCX,RDX,R8,R9,栈，栈，栈，……（栈仍然是反向操作）
;寄存器使用约定：https://msdn.microsoft.com/zh-cn/library/9z1stfyw.aspx
;我还不知道这个proc在声明中是什么意思
_localtime64	proto ret_llptr_rax:proc,	plltime_llptr_rcx:QWORD
_time64			proto ret_ll_rax:proc,		ptmt_llptr_rcx:QWORD
printf			proto ret_int_rax:proc,		szFormat_bptr_rcx:QWORD,	:VARARG

;>=VS2015需要
includelib legacy_stdio_definitions.lib
includelib ucrt.lib

tm struct
	tm_sec dd ?
	tm_min dd ?
	tm_hour dd ?
	tm_mday dd ?
	tm_mon dd ?
	tm_year dd ?
	tm_wday dd ?
	tm_yday dd ?
	tm_isdst dd ?
tm ends

.data
szTmfmt db "Hello! NowTime: %d:%d:%d",0ah,0

.data?
ts1 dq ?

.code
mainCRTStartup proc
	;调用time64
	sub rsp,10h;64位的需要自己调整栈指针，指针后退参数+返回值字节长度
	xor rcx,rcx
	call _time64
	add rsp,10h;可以在开始时直接退28h然后中间的栈指针操作不要，但我不知道这样会不会有什么潜在的问题

	mov ts1,rax
	
	;调用localtime64
	sub rsp,10h
	lea rcx,ts1
	call _localtime64
	add rsp,10h
	
	;调用printf
	sub rsp,28h
	lea rcx,szTmfmt
	mov edx,(tm PTR[rax]).tm_hour;这样居然也可以，，，注意R_X取低32位时用E_X
	mov r8d,(tm PTR[rax]).tm_min;而R8～R15取低32位时用R8D～R15D
	mov r9d,(tm PTR[rax]).tm_sec
	call printf
	add rsp,28h

	;以下相当于return 0
	mov rax,0
	ret
mainCRTStartup endp
end
