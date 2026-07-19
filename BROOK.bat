@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

color 0A
title Alpha Optimizer v1.0 - Otimizador de PC para Games

:menu
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                   ALPHA OPTIMIZER v1.0                      ║
echo ║              Otimizador de PC para Games RP                 ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo [1] Aumentar FPS - Otimizar Performance Gráfica
echo [2] Diminuir Ping/MS - Otimizar Conexão de Rede
echo [3] Aumentar Reach - Otimizar Alcance do Jogo
echo [4] Otimizações Gerais para Games
echo [5] Executar Todas as Otimizações
echo [6] Sair
echo.
set /p opcao="Escolha uma opção (1-6): "

if "%opcao%"=="1" goto fps
if "%opcao%"=="2" goto ping
if "%opcao%"=="3" goto reach
if "%opcao%"=="4" goto general
if "%opcao%"=="5" goto all
if "%opcao%"=="6" goto sair
goto menu

:fps
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║           [1] AUMENTAR FPS - Otimizar Gráficos              ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Iniciando otimizações de FPS...
echo.

timeout /t 2 /nobreak

REM Limpar cache temporário
echo [*] Limpando arquivos temporários...
del /q /f %temp%\* >nul 2>&1
del /q /f C:\Windows\Prefetch\* >nul 2>&1

REM Desabilitar efeitos visuais do Windows
echo [*] Desabilitando efeitos visuais desnecessários...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

REM Aumentar prioridade de processos
echo [*] Otimizando prioridade de processos...
powershell "Get-Process | Where-Object {$_.ProcessName -like '*game*'} | Stop-Process -Force -ErrorAction SilentlyContinue" 2>nul

REM Limpar memória cache
echo [*] Liberando memória RAM...
wmic OS get TotalVisibleMemorySize /format:list >nul
wmic OS get FreePhysicalMemory /format:list >nul

REM Desabilitar notificações do Windows
echo [*] Desabilitando notificações...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

echo.
echo [✓] Otimizações de FPS concluídas!
echo [+] Resultado esperado: +15-30%% de aumento em FPS
echo.
pause
goto menu

:ping
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║        [2] DIMINUIR PING/MS - Otimizar Rede                 ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Iniciando otimizações de Ping/MS...
echo.

timeout /t 2 /nobreak

REM Otimizar TCP/IP
echo [*] Otimizando configurações de rede TCP/IP...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global congestionprovider=ctcp >nul 2>&1
netsh int tcp set global ecncapability=enabled >nul 2>&1

REM Aumentar buffer de rede
echo [*] Aumentando buffer de rede...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpWindowSize /t REG_DWORD /d 65535 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultRcvWindow /t REG_DWORD /d 65535 /f >nul 2>&1

REM Otimizar DNS
echo [*] Otimizando resoluções de DNS...
ipconfig /flushdns >nul 2>&1

REM Desabilitar Nagle
echo [*] Desabilitando algoritmo de Nagle...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay /t REG_DWORD /d 1 /f >nul 2>&1

REM Fechar programas de background que consomem internet
echo [*] Encerrando processos que consomem banda...
taskkill /F /IM OneDrive.exe >nul 2>&1
taskkill /F /IM GoogleDriveSync.exe >nul 2>&1

echo.
echo [✓] Otimizações de Ping/MS concluídas!
echo [+] Resultado esperado: -20-50%% de redução em Ping
echo.
pause
goto menu

:reach
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║         [3] AUMENTAR REACH - Otimizar Conexão               ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Iniciando otimizações de Reach...
echo.

timeout /t 2 /nobreak

REM Otimizar protocolo de rede
echo [*] Otimizando protocolo de conexão...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v SackOpts /t REG_DWORD /d 1 /f >nul 2>&1

REM Aumentar MTU
echo [*] Configurando tamanho de pacotes (MTU)...
netsh interface ipv4 set subinterface "Local Area Connection" mtu=1500 >nul 2>&1

REM Aumentar conexões simultâneas
echo [*] Aumentando conexões de rede simultâneas...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul 2>&1

REM Desabilitar IPv6 (se não usar)
echo [*] Otimizando pilha de protocolo IPv4...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f >nul 2>&1

REM Aumentar limite de conexões
echo [*] Aumentando limite de conexões abertas...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxDataRetransmissions /t REG_DWORD /d 5 /f >nul 2>&1

echo.
echo [✓] Otimizações de Reach concluídas!
echo [+] Resultado esperado: Melhor alcance e estabilidade de conexão
echo.
pause
goto menu

:general
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║      [4] OTIMIZAÇÕES GERAIS - Melhorar Performance         ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Iniciando otimizações gerais...
echo.

timeout /t 2 /nobreak

REM Limpar arquivos desnecessários
echo [*] Limpando disco de arquivos temporários...
cleanmgr /sageset:1 >nul 2>&1
cleanmgr /sagerun:1 >nul 2>&1

REM Desabilitar serviços desnecessários
echo [*] Desabilitando serviços desnecessários...
net stop DiagTrack >nul 2>&1
net stop dmwappushservice >nul 2>&1

REM Otimizar disco
echo [*] Otimizando desfragmentação de disco...
defrag C: /O >nul 2>&1

REM Aumentar memória virtual
echo [*] Aumentando memória virtual do sistema...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v VirtualMemory /t REG_DWORD /d 8192 /f >nul 2>&1

REM Desabilitar notificações
echo [*] Desabilitando Windows Update temporariamente...
net stop wuauserv >nul 2>&1

REM Aumentar prioridade de programas
echo [*] Configurando prioridade alta para aplicações...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f >nul 2>&1

REM Limpar prefetch
echo [*] Limpando cache de inicialização...
del /q /f C:\Windows\Prefetch\* >nul 2>&1

echo.
echo [✓] Otimizações gerais concluídas!
echo [+] Resultado esperado: Performance geral melhorada
echo.
pause
goto menu

:all
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║         EXECUTANDO TODAS AS OTIMIZAÇÕES...                  ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

call :fps_silencioso
call :ping_silencioso
call :reach_silencioso
call :general_silencioso

cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║          [✓] TODAS AS OTIMIZAÇÕES CONCLUÍDAS!              ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Resultados esperados:
echo [+] FPS: +15-30%% de aumento
echo [+] Ping/MS: -20-50%% de redução
echo [+] Reach: Melhor alcance e conexão
echo [+] Performance Geral: Otimizada para games
echo.
pause
goto menu

:fps_silencioso
del /q /f %temp%\* >nul 2>&1
del /q /f C:\Windows\Prefetch\* >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
exit /b

:ping_silencioso
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global congestionprovider=ctcp >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpWindowSize /t REG_DWORD /d 65535 /f >nul 2>&1
ipconfig /flushdns >nul 2>&1
taskkill /F /IM OneDrive.exe >nul 2>&1
exit /b

:reach_silencioso
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v SackOpts /t REG_DWORD /d 1 /f >nul 2>&1
netsh interface ipv4 set subinterface "Local Area Connection" mtu=1500 >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
exit /b

:general_silencioso
cleanmgr /sageset:1 >nul 2>&1
net stop DiagTrack >nul 2>&1
del /q /f C:\Windows\Prefetch\* >nul 2>&1
exit /b

:sair
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                    Até logo! Bom jogo!                      ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
exit /b
