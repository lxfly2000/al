;https://www.pediy.com/kssd/pediy09/pediy09-602.htm
;ML64��֧�ָ߼���������
;�����洢λ�ã�RCX,RDX,R8,R9,ջ��ջ��ջ��������ջ��Ȼ�Ƿ��������
;�Ĵ���ʹ��Լ����https://msdn.microsoft.com/zh-cn/library/9z1stfyw.aspx
;�һ���֪�����proc����������ʲô��˼
_localtime64	proto ret_llptr_rax:proc,	plltime_llptr_rcx:QWORD
_time64			proto ret_ll_rax:proc,		ptmt_llptr_rcx:QWORD
printf			proto ret_int_rax:proc,		szFormat_bptr_rcx:QWORD,	:VARARG

;>=VS2015��Ҫ
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
	;����time64
	sub rsp,10h;64λ����Ҫ�Լ�����ջָ�룬ָ����˲���+����ֵ�ֽڳ���
	xor rcx,rcx
	call _time64
	add rsp,10h;�����ڿ�ʼʱֱ����28hȻ���м��ջָ�������Ҫ�����Ҳ�֪�������᲻����ʲôǱ�ڵ�����

	mov ts1,rax
	
	;����localtime64
	sub rsp,10h
	lea rcx,ts1
	call _localtime64
	add rsp,10h
	
	;����printf
	sub rsp,28h
	lea rcx,szTmfmt
	mov edx,(tm PTR[rax]).tm_hour;������ȻҲ���ԣ�����ע��R_Xȡ��32λʱ��E_X
	mov r8d,(tm PTR[rax]).tm_min;��R8��R15ȡ��32λʱ��R8D��R15D
	mov r9d,(tm PTR[rax]).tm_sec
	call printf
	add rsp,28h

	;�����൱��return 0
	mov rax,0
	ret
mainCRTStartup endp
end
