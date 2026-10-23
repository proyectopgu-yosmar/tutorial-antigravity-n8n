@echo off
title Asistente de Instalacion - Antigravity + n8n + GitHub
cd /d "%~dp0"

echo =====================================================================
echo    ASISTENTE DE INSTALACION: ANTIGRAVITY + n8n + GITHUB (PROYECTO PGU)
echo =====================================================================
echo.
echo Iniciando el Asistente Grafico de Windows...
echo Por favor espera un segundo.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0Instalador_Wizard.ps1"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Ejecutando con permisos adicionales...
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Instalador_Wizard.ps1"
)

exit
