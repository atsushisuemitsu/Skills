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
- 以下のセクションを記載（各項目300字以内、コード詳細は含まない）:
  - 【背景】: RedMineチケットの説明または修正が必要となった経緯
  - 【目的と適用範囲】: 修正の目的と影響範囲
  - 【内容】: 修正内容の概要（機能説明のみ）
  - 【効果】: 修正による改善効果
  - 【Diff結果】: 変更されたファイルの一覧

### 5. 出力
- ファイル名: `リリースノート_[顧客名]_[概要](SOFT-[装置名]-RP-XXXX).csv`

## 記載ルール（お客様向け文書）

**重要**: お客様はプログラムの詳細を知らないため、技術的な内容は一切記載しない

### 禁止事項
- ❌ 変数名、関数名、クラス名（例: MI_WORKCLAMPMOVING, MO_IMAGE_INPUT_NOW）
- ❌ ファイル名、パス（対象ファイル欄以外）
- ❌ プログラムの内部処理、アルゴリズム
- ❌ エラーコード、例外処理の詳細
- ❌ メモリ、信号、通信などの技術用語

### 推奨する表現
- ✅ 「検査時間が遅くなる問題を改善しました」
- ✅ 「非常停止後の再開時にデータが正しく処理されるようになりました」
- ✅ 「装置の安定稼働が向上します」

### 避けるべき表現
- ❌ 「MI_WORKCLAMPMOVING信号のOFF待ち処理を追加」
- ❌ 「メモリリークが解消されます」
- ❌ 「NAutoAlInsp3.cppの処理を修正」

### 基本方針
- 各項目は300字以内でまとめる
- 変更の「何を」「なぜ」を重視し、「どのように」は省略
- 効果は業務視点（お客様のメリット）で記載

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
