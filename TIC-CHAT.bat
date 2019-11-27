@echo off
SETLOCAL EnableDelayedExpansion
mode 90,30
title TIC CHAT

REM Multiproceso
:startExtraThread
if not "%1" == "" goto %1

REM ESTO ES PARA LOS COLORES
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

cls
echo.
set/p "serv=Servidor: Inves"
if [%serv%]==[] exit
set "serverf=\\Inves%serv%\D\Mis Documentos\CT\_SERVER"

REM cargar datos del servidor (server.ccc)
< "%serverf%\server.ccc" (
set/p ccolor=
set/p wcolor=
set/p wtext=
set/p cfrec=
)
color %ccolor%
set file=%serverf%\roomdata

:start
cls
REM Se alternan todos los colores para limpiar el buffer de la imagen
color f0
color 0f
color %ccolor%

REM Insertar la foto
call "%serverf%\insertbmp.exe" /p:"%serverf%\banner.bmp" /x:0 /y:12 /z:100

REM Establecer la posicion del texto con 'cursor'
call "%serverf%\cursor.exe" 3 20
REM Aqui se llama a la funcion que colorea el texto
call :ColorText %wcolor% "%wtext%"
call "%serverf%\cursor.exe" 4 22
set/p "nick=Seudonimo: "
if [%nick%] == [] goto start

REM Iniciar el textbox
start "" "%0" TEXTUAL %serv% %nick% %ccolor%
call "%serverf%\cmdow" @ /TOP
echo -- %nick% se ha unido  [%time%]>> %file%

:chat
cls
color f0
color 0f
color %ccolor%

TITLE TIC CHAT2

echo.
REM Leer todos los mensajes
for /f "tokens=*" %%A in (%file%) do ( echo %%A )

REM Obtener la posicion de la ventana del textbox
for /f "tokens=2,8-9" %%a in ('%serverf%\cmdow "TIC CHAT" /p') do (
	set "LEFT=%%b" & set "TOP=%%c"
)
REM Establecer la posicion de esta ventana en funcion de la otra
set/a "TOP=%TOP%+32"
call "%serverf%\cmdow" @ /MOV %LEFT% %TOP%

REM Escuchar la señal "blah" para refrescar (obsoleto)
REM waitfor "blah" /t %cfrec% >nul

timeout /t %cfrec% >nul

REM Obtener la posicion de la ventana del textbox
for /f "tokens=2,8-9" %%a in ('%serverf%\cmdow "TIC CHAT" /p') do (
	set "LEFT=%%b" & set "TOP=%%c"
)
REM Establecer la posicion de esta ventana en funcion de la otra
set/a "TOP=%TOP%+32"
call "%serverf%\cmdow" @ /MOV %LEFT% %TOP%
goto chat

:TEXTUAL
REM Aqui va el textbox
TITLE TIC CHAT
mode 90,3

REM Leer variables
set "serv=%2"
set "nick=%3"
set "ccolor=%4"

set "servf=\\Inves%serv%\D\Mis Documentos\CT\_SERVER"

color %ccolor%
call "%serverf%\cmdow" @ /TOP
set file=%serverf%\roomdata

:TEXTUAL2
cls
echo.
set/p "ptext=>>> "
REM Este echo no es para mostrar un texto, sino para escribir en el archivo del server
echo [%time%] %nick% : %ptext%>> %file%
REM Enviar señal de refresco (obsoleto)
REM waitfor /si "blah">nul
goto TEXTUAL2


exit
:ColorText
REM Esta funcion sirve para dar color a un texto
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof