:: Check if the program runs with elevated privileges since they are needed to change the year. 
@echo OFF

SET TARGET_DIRECTORY="CHEMIN VERS VOTRE EXE"
SET TARGETED_YEAR=2012

WHOAMI /Groups | FIND "12288" >NUL
IF ERRORLEVEL 1 (
	@powershell Start-Process cmd -Verb RunAs -WindowStyle Hidden -ArgumentList{/k %0%}
	EXIT /B 1
	)
:: If we have elevated privileges:
SET /A OFFSET=%Date:~6,4%-%TARGETED_YEAR%
DATE %date:~0,2%-%date:~3,2%-%TARGETED_YEAR%
:: Start the process, will wait for it to finish.
%TARGET_DIRECTORY%
:: Reset the time
SET /A ACTUALYEAR=%Date:~6,4%+%OFFSET%
DATE %date:~0,2%-%date:~3,2%-%ACTUALYEAR%
