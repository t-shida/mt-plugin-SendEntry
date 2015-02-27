# mt-plugin-SendEntry

保存した記事を別のMovable Typeへ自動的にコピーし公開するプラグインです。

## インストール
1. プラグインをダウンロードします。
2. ダウンロードしたアーカイブファイルを解凍します。
3. plugins/SendEntryディレクトリをMovable Typeのプラグインディレクトリ(/path/to/mt/plugins/)にコピーします。

####動作環境
* Amazon Linux
* Movable Type Pro version 6.1

####使用ライブラリ
* LWP::UserAgent
* HTTP::Request
* JSON

## 使い方
####プラグインの設定
plugins/SendEntry/config.yamlのconfig_settings...の値を以下のように記述します。  
対象のMovable Typeはコピーを受け取る側のものとなります。  
`config_settings.se_mt_api_url.default = Movable Type DataAPIのURL`  
`config_settings.se_mt_username.default = Movable Typeのユーザー名` 
`config_settings.se_mt_password.default = Movable Typeのパスワード`  
`config_settings.se_mt_blog_id.default = ブログID`

####記事の作成時
プラグインが有効の場合、記事の保存と同時に自動的に実行されます。

- - -

##### 参照サイト
<http://www.h-fj.com/blog/archives/2013/07/18-144627.php>  
<http://weeeblog.net/blog/2013/08/04_2301.php>  
<http://blog.drikin.com/2013/12/movable-type-6data-api.html>  

