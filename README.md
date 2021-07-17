# RhoHiについて
## 概要
*出張や旅費の情報を登録・承認依頼を出すことができます。  
*adminユーザーは承認依頼があった申請を承認・否認できます。

## URL
  https://rhohi.herokuapp.com/
 
## 制作のきっかけ
*普段の業務で使っている旅費申請アプリをRailsで作ってみたいと思ったため。

## 重視した点
*実際の業務での使用を想定し、ユーザーのアクションに制限を作成した。  
*Railチュートリアルでは使用しなかった技術を導入した。  
### 導入した技術等
*deviseを用いたユーザー認証  
*DBにMySQLを使用  
*多層的なモデル構造の導入  

## 技術スタック
*言語: Ruby2.5.5  
*フレームワーク: Ruby on Rails5.2.3  
*DB: MySQL8.0.25  
*インフラ: Heroku  
*バージョン管理: Git  

## 実装した機能の概要
### 申請関連
*出張申請を作成できる。  
*出張申請に紐付けた旅費情報を登録できる。  
*申請中・承認済み・返戻（否認）済みの申請を一覧で確認できる。  

### 承認関連
*承認待ち・承認済み・否認済みの申請を一覧で確認できる。  
*adminユーザーは一般ユーザーの出張申請に対して承認・否認を行うことができる。  
*否認時はコメントを付与できる。  
*自社他ユーザーの提出済・承認済申請に対し、承認以外の操作を制限している。  
*他社ユーザーの申請に対し、全ての操作を制限している。  

### 認証・ユーザー管理
*adminユーザーはユーザーの新規作成・招待メールの発行ができる。  
*外部からの新規登録は不可としている。（クローズドな運用を想定のため）  

### その他
*承認ステータスに応じてビューの表示を変え、誤操作を防ぐ。  

## 今後のアップデートについて
### 実装したい機能
*運賃・料金、手当額の全角文字入力に対応  
*集計機能の実装  
### 導入したい技術
*テスト環境にDockerを導入  
*AWSのEC2に本番環境を移行  

