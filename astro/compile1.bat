@echo off
for /r .  %%i in (*.cpp)do (

setlocal enabledelayedexpansion

set var=%%i

set file_path=!var!
set str1=!file_path!
set str2=!file_path!
set ch1=\

::注意，这里是区分大小写的！
set str=!str1!

::复制字符串，用来截短，而不影响源字符串
call:next
echo !file_path!
cd !file_path!
set str=!str1!
call:find_file_name
set file_name=!file_name:~1,-5!
echo !file_name!
cd !file_path!
g++ %%i -o !file_name!
pause
cd ../
)
goto :eof

:next
	if not "!str!"=="" (
	set /a num+=1
             :
	if "!str:~-1!"=="!ch1!" (set file_path=!str! 
                  
              
                    set str=""
              )
	if not "!str!"=="" (
	set "str=!str:~0,-1!")
 	call:next
	)
goto :eof

:find_file_name
	if not "!str!"=="" (
	set /a num+=1
                set str2=!str1:
	if "!str:~0,1!"=="!ch1!" (set file_name=!str! 
                  
              
                  
              )
	if not "!str!"=="" (
	set "str=!str:~1!")
 	call:find_file_name
	)
goto :eof