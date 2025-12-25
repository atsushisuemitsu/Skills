---
description: ソフトウェアリリースノートを自動生成する
allowed-tools: Read, Glob, Grep, Bash, Write, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot, mcp__playwright__browser_click, mcp__playwright__browser_type, mcp__playwright__browser_wait_for
---

# リリースノート自動生成

以下の情報を元に、ソフトウェアリリースノートを作成してください。

## 入力パラメータ

$ARGUMENTS

## 処理手順

### 1. History.txt解析
- 指定されたHistory.txtをShift-JISエンコーディングで読み込む
- ファイル先頭から最新のエントリ（最も新しい【更新日時】）を特定
- 以下のフィールドを抽出:
  - バージョン番号: `GATS2120 Vx.x.xx.xx`
  - 更新日時: 【更新日時　　】
  - 更新区分: 【更新区分　　】
  - 更新内容: 【更新内容　　】
  - 対象ファイル: 【対象ファイル】
  - チケット番号: 更新内容内の `#xxxxx` パターン

### 2. RedMineチケット情報取得（--ticket指定時）
チケット番号が指定された場合、Playwrightでブラウザを開いてRedMineから情報を取得：

1. `mcp__playwright__browser_navigate` で RedMine URLを開く
   - URL: `https://read-sln.cloud.redmine.jp/issues/[チケット番号]`
2. ユーザーに「RedMineにログインしてください。ログイン完了したら教えてください」と伝える
3. ログイン完了後、`mcp__playwright__browser_snapshot` でページ内容を取得
4. チケットから以下の情報を抽出:
   - タイトル（題名）
   - 説明
   - ステータス
   - 担当者
   - 関連チケット

### 3. フォルダ比較（Diff）
- 修正前と修正後のフォルダを比較
- 変更されたファイルの一覧を生成

### 4. リリースノート生成
- CSVテンプレート（~/.claude/skills/release-note/templates/release-note-template.csv）を使用
- 以下のセクションを記載（各項目最大4行、コード詳細は含まない）:
  - 【背景】: RedMineチケットの説明または修正が必要となった経緯
  - 【目的と適用範囲】: 修正の目的と影響範囲
  - 【内容】: 修正内容の概要（機能説明のみ）
  - 【効果】: 修正による改善効果
  - 【Diff結果】: 変更されたファイルの一覧

### 5. 出力
- ファイル名: `リリースノート_[顧客名]_[概要](SOFT-[装置名]-RP-XXXX).csv`

## 記載ルール

- 各項目は最大4行で簡潔に記述
- コードの直接記載は禁止 - 機能説明のみ
- 技術用語は必要最小限に抑える
- 変更の「何を」「なぜ」を重視し、「どのように」は省略

## 使用例

### RedMineチケット情報も取得する場合
```
/release-note --before "D:\Release\v1.0.25.0" --after "D:\Release\v1.0.26.0" --history "D:\Release\History.txt" --customer "NANYA錦興" --device "G2128" --ticket 69777
```

### History.txtのみから生成する場合
```
/release-note --before "D:\Release\v1.0.25.0" --after "D:\Release\v1.0.26.0" --history "D:\Release\History.txt" --customer "NANYA錦興" --device "G2128"
```

## RedMine URL

- ベースURL: https://read-sln.cloud.redmine.jp/
- チケットURL: https://read-sln.cloud.redmine.jp/issues/[チケット番号]
