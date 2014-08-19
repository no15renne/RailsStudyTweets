railsの勉強にtwitterらしき何かをつくる

<参考>
小学生でもわかる Ruby on rails 入門
http://openbook4.me/projects/92

deviseとcancanによるログイン機能の実装
http://morizyun.github.io/blog/devise-cancan-rails-authorize/

あといろんなとこ

<動かすまで>
bundle install　を実行
rake db:migrate を実行
rake db:seed を実行
ブラウザで0.0.0.0:3000/　にアクセス
one@test.com
two@test.com
three@test.com
のいずれかでログインpass共通でhogehoge
もしくはユーザ登録(emailは別に使わないので適当に

<概要>
index
	自分とフォローしているユーザのtweetを表示
show/:username
	ユーザのツイート、フォローしているユーザなどの表示
	自分のページでは新しいtweetを作成するnewへのリンク、それ以外のページではfollowのリンクを表示
new/:username
	tweetの作成
