# Agent Skills Collection

Claude CodeとGitHub Copilot用のカスタムスキル集です。

## 概要

このリポジトリには、Claude CodeとGitHub Copilotで使用できるカスタムスキルが含まれています。
各スキルは特定のタスクを自動化し、開発効率を向上させます。

## スキル一覧

| スキル名 | 説明 | 状態 |
|---------|------|------|
| [release-note](./release-note/) | ソフトウェアリリースノート自動生成 | 利用可能 |

## インストール方法

### GitHub Copilot（Windows）

リポジトリをダウンロード・展開し、`install-copilot.bat` をダブルクリックしてください。PowerShellからも実行できます。

```powershell
.\install-copilot.bat
```

スキルとCSVテンプレートを `%USERPROFILE%\.copilot\skills\release-note` にコピーします。既存の同名ファイルは更新されます。VS Code の `files.encoding` が `shiftjis` でも文字化けしないよう、コピー後の `SKILL.md` は UTF-8（BOM付き）で保存します。`~/.agents/skills` や `~/.claude/skills` に同名の `release-note` があると VS Code がそちらを使う場合があるため、Copilot で使うものだけを残してください。BAT単体ではなく、隣の `release-note` フォルダも必要です。

Copilot CLIでは `/skills reload` の後、`/skills info release-note` で認識を確認してください。VS Codeではウィンドウを再読み込みし、Copilotチャットで `/release-note` を指定して依頼します。

```text
/release-note スキルでリリースノートを作成してください。
修正前: D:\Release\old
修正後: D:\Release\new
履歴: D:\Release\new\History.txt
顧客: UMTC蘇州
装置: G2128
出力先: D:\Release\リリースノート.xlsm
```

出力先に既存のXLSMを指定すると、そのブックを更新します。RedMineへのログインやExcel編集に必要なツールは、使用する環境で用意してください。

配置先・再読み込み手順: [GitHub公式ドキュメント](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-skills)、[VS Code公式ドキュメント](https://code.visualstudio.com/docs/agent-customization/agent-skills)。自動実行では `.\install-copilot.bat /nopause` で終了時のキー入力待ちを省略できます。

### Claude Code

### 方法1: インストーラーを使用（推奨）

```powershell
# install.bat をダブルクリック、または以下を実行
.\install.bat
```

### 方法2: 手動コピー

```powershell
# Windows - スキルとコマンドをインストール
xcopy /E /I "release-note" "%USERPROFILE%\.claude\skills\release-note"
xcopy /E /I "commands" "%USERPROFILE%\.claude\commands"

# Mac/Linux
cp -r release-note ~/.claude/skills/
cp -r commands/* ~/.claude/commands/
```

### 方法3: プロジェクトディレクトリに配置（チーム共有）

```powershell
# プロジェクトのルートで実行
xcopy /E /I "path\to\release-note" ".claude\skills\release-note"
```

## 使用方法

各スキルのディレクトリ内にある `SKILL.md` を参照してください。

### release-note スキル

```
/release-note --before "修正前フォルダ" --after "修正後フォルダ" --history "History.txt" --customer "顧客名" --device "装置名"
```

詳細: [release-note/SKILL.md](./release-note/SKILL.md)

## ディレクトリ構成

```
Skills/
├── README.md                 # このファイル
├── install.bat               # Claude Code用インストーラー
├── install-copilot.bat       # GitHub Copilot用インストーラー
├── commands/                 # スラッシュコマンド
│   └── release-note.md       # /release-note コマンド
├── release-note/             # リリースノート生成スキル
│   ├── SKILL.md              # スキル定義
│   └── templates/            # テンプレートファイル
│       └── release-note-template.csv
└── (将来のスキル)/
```

## 要件

- Claude Code CLI、またはAgent Skillsに対応したGitHub Copilot CLI / VS Code
- 各スキルの依存関係は個別のSKILL.mdに記載

## ライセンス

社内利用

## 更新履歴

### 2025-12-25
- `/release-note` スラッシュコマンドを追加
- release-note スキルを追加
- History.txt形式（GATS2120形式）に対応
- CSVテンプレートを追加
- 初期リリース
