.model flat,stdcall

include asm2.inc

.code
Hello proc stdcall szMsg
	invoke MessageBoxA,0,szMsg,0,40h
	ret
Hello endp
end
