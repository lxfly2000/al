.model flat,stdcall

include asm2.inc

.data
szTmfmt db "%d:%d:%d",0ah,0
szCheck db "CHCHCH",0

.data?
ts1 dq ?

.code
PrintNowTime proc C
	invoke _time64,0 ;64λ����ֵ��λ��edx,��λ��eax
	lea ebx,ts1
	mov DWORD PTR[ebx],eax ;ע��ߵ�λ˳��
	mov DWORD PTR[ebx+4],edx
	invoke _localtime64,addr ts1
	invoke printf,addr szTmfmt,(tm PTR[eax]).tm_hour,(tm PTR[eax]).tm_min,(tm PTR[eax]).tm_sec ;���ˡ������������д�ľ�Ȼ���ԣ�����
	ret
PrintNowTime endp
end
