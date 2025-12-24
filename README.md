# Claude Code Skills Collection

Claude Code用のカスタムスキル集です。

## 概要

このリポジトリには、Claude Codeで使用できるカスタムスキルが含まれています。
各スキルは特定のタスクを自動化し、開発効率を向上させます。

## スキル一覧

| スキル名 | 説明 | 状態 |
|---------|------|------|
| [release-note](./release-note/) | ソフトウェアリリースノート自動生成 | 利用可能 |

## インストール方法

### 方法1: ユーザーディレクトリにコピー（個人利用）

```powershell
# Windows
xcopy /E /I "release-note" "%USERPROFILE%\.claude\skills\release-note"

# Mac/Linux
cp -r release-note ~/.claude/skills/
```

### 方法2: プロジェクトディレクトリに配置（チーム共有）

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
├── release-note/             # リリースノート生成スキル
│   ├── SKILL.md              # スキル定義
│   └── templates/            # テンプレートファイル
│       └── release-note-template.csv
└── (将来のスキル)/
```

## 要件

- Claude Code CLI
- 各スキルの依存関係は個別のSKILL.mdに記載

## ライセンス

社内利用

## 更新履歴

### 2025-12-25
- release-note スキルを追加
- 初期リリース
