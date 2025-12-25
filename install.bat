@echo off
chcp 65001 > nul
echo ============================================
echo   Claude Code Skills インストーラー
echo ============================================
echo.

REM スクリプトのディレクトリを取得
set SCRIPT_DIR=%~dp0

REM インストール先ディレクトリ
set SKILLS_DIR=%USERPROFILE%\.claude\skills
set COMMANDS_DIR=%USERPROFILE%\.claude\commands

REM ディレクトリ作成
echo [1/4] ディレクトリを作成中...
if not exist "%SKILLS_DIR%" mkdir "%SKILLS_DIR%"
if not exist "%COMMANDS_DIR%" mkdir "%COMMANDS_DIR%"

REM スキルをコピー
echo [2/4] release-note スキルをインストール中...
xcopy /E /I /Y "%SCRIPT_DIR%release-note" "%SKILLS_DIR%\release-note" > nul
if %ERRORLEVEL% EQU 0 (
    echo     ✓ スキルをインストールしました
) else (
    echo     ✗ スキルのインストールに失敗しました
)

REM コマンドをコピー
echo [3/4] release-note コマンドをインストール中...
xcopy /Y "%SCRIPT_DIR%commands\*" "%COMMANDS_DIR%\" > nul
if %ERRORLEVEL% EQU 0 (
    echo     ✓ コマンドをインストールしました
) else (
    echo     ✗ コマンドのインストールに失敗しました
)

REM 完了
echo [4/4] インストール完了
echo.
echo ============================================
echo   インストール先:
echo   - スキル: %SKILLS_DIR%\release-note
echo   - コマンド: %COMMANDS_DIR%\release-note.md
echo ============================================
echo.
echo Claude Code を再起動してください。
echo.
pause
