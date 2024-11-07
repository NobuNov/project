@echo off
setlocal

REM コードページをUTF-8に設定して文字化けを防ぐ
chcp 65001 >nul

REM WSLのインストール状況を確認
wsl --status >nul 2>&1
if %errorlevel%==0 (
    echo WSL is already installed.
    
    REM WSL 2のサポートが有効かどうか確認
    wsl --list --verbose | findstr "2" >nul
    if %errorlevel%==0 (
        echo WSL 2 is already enabled.
        REM PowerShellを使ってセットアップ完了のポップアップを表示
        powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('セットアップはされています！', '情報', 'OK', 'Information')"
        goto :end
    )
) else (
    REM WSLをインストール
    echo Installing WSL...
    wsl --install
)

REM WSL 2のサポートを有効にする
echo Enabling WSL 2...
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

REM 再起動を促すメッセージ
echo.
echo WSL is installed. Your system will restart in 10 seconds to complete the installation.
timeout /t 10 /nobreak >nul

REM 再起動
shutdown /r /t 0

:end
endlocal
