@echo off
set /p ops="��ָ�����ѡ�� [0 - ȫ�� | 1 - src | 2 - src + pom.xml]��"
echo ָ���Ĵ��ѡ��Ϊ��%ops%
rd /s /q .\common-lib
md .\common-lib
for /f %%v in (common-system.txt) do (
	if %ops% == 0 (
		xcopy /e /y /c /h /r ..\%%v\src .\common-lib\%%v\src\
		copy ..\%%v\.classpath .\common-lib\%%v\.classpath
		copy ..\%%v\.project .\common-lib\%%v\.project
		copy ..\%%v\pom.xml .\common-lib\%%v\pom.xml
	) else if %ops% == 1 (
		xcopy /e /y /c /h /r ..\%%v\src .\common-lib\%%v\src\
	) else if %ops% == 2 (
		xcopy /e /y /c /h /r ..\%%v\src .\common-lib\%%v\src\
		copy ..\%%v\pom.xml .\common-lib\%%v\pom.xml
	)
)
PAUSE