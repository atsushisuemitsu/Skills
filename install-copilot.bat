@echo off
setlocal DisableDelayedExpansion
chcp 65001 > nul

set "SOURCE_DIR=%~dp0release-note"
set "SKILL_DIR=%USERPROFILE%\.copilot\skills\release-note"

echo ============================================
echo   GitHub Copilot release-note インストーラー
echo ============================================
echo.

if not defined USERPROFILE goto :profile_error
if not exist "%SOURCE_DIR%\SKILL.md" goto :source_error
if not exist "%SOURCE_DIR%\templates\release-note-template.csv" goto :source_error

echo [1/2] インストール先を作成中...
if not exist "%SKILL_DIR%\" mkdir "%SKILL_DIR%"
if not exist "%SKILL_DIR%\" goto :directory_error

echo [2/2] スキルとテンプレートをコピー中...
xcopy "%SOURCE_DIR%\*" "%SKILL_DIR%\" /E /I /Y > nul
if errorlevel 1 goto :copy_error
if not exist "%SKILL_DIR%\SKILL.md" goto :copy_error
if not exist "%SKILL_DIR%\templates\release-note-template.csv" goto :copy_error

echo.
echo インストールが完了しました。
echo インストール先: "%SKILL_DIR%"
echo Copilot CLIでは /skills reload の後、/skills info release-note で確認してください。
echo VS Codeではウィンドウを再読み込みし、チャットで /release-note を指定してください。
if /I not "%~1"=="/nopause" pause
exit /b 0

:profile_error
echo [ERROR] USERPROFILEが設定されていません。
goto :failed

:source_error
echo [ERROR] コピー元のスキルまたはテンプレートが見つかりません。
echo このBATを、release-noteフォルダと同じ場所に配置してください。
goto :failed

:directory_error
echo [ERROR] インストール先を作成できません: "%SKILL_DIR%"
goto :failed

:copy_error
echo [ERROR] スキルのコピーに失敗しました: "%SKILL_DIR%"

:failed
if /I not "%~1"=="/nopause" pause
exit /b 1
