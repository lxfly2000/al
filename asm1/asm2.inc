;>=VS2015ะ่าช
includelib legacy_stdio_definitions.lib
includelib ucrt.lib

printf proto C szFormat:DWORD,:VARARG
scanf proto C szFormat:DWORD,:VARARG

PrintNowTime proto C

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

_localtime64 proto C plltime:DWORD
_time64 proto C ptmt:DWORD
