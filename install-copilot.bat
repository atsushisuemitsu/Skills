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

echo [1/3] インストール先を作成中...
if not exist "%SKILL_DIR%\" mkdir "%SKILL_DIR%"
if not exist "%SKILL_DIR%\" goto :directory_error

echo [2/3] スキルとテンプレートをコピー中...
xcopy "%SOURCE_DIR%\*" "%SKILL_DIR%\" /E /I /Y > nul
if errorlevel 1 goto :copy_error
if not exist "%SKILL_DIR%\SKILL.md" goto :copy_error
if not exist "%SKILL_DIR%\templates\release-note-template.csv" goto :copy_error

echo [3/3] SKILL.mdをUTF-8(BOM付き)に変換中...
REM VS Codeのfiles.encodingがshiftjisでも文字化けしないよう、BOMでUTF-8を明示する
set "SKILL_FILE=%SKILL_DIR%\SKILL.md"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=$env:SKILL_FILE; $t=[IO.File]::ReadAllText($p,[Text.Encoding]::UTF8); [IO.File]::WriteAllText($p,$t,(New-Object Text.UTF8Encoding($true)))"
if errorlevel 1 goto :encoding_error

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
goto :failed

:encoding_error
echo [ERROR] SKILL.mdのUTF-8(BOM付き)変換に失敗しました: "%SKILL_FILE%"

:failed
if /I not "%~1"=="/nopause" pause
exit /b 1
