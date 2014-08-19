class TweetsController < ApplicationController
before_filter :authenticate_admin_user!
  

  def existpage(_username)
    if AdminUser.exists?(:username => _username) then return true;
    else return false;
    end
  end

  def index
    #followしてるすべてのユーザ情報一覧取得
    _followidlist = Follow.where(userid: current_admin_user.id).all 
    @follows = []	#宣言してないと怒られる（もうちょい綺麗にしたい
    _followidlist.each do |fi|
      @follows.push(AdminUser.find(fi.followuserid))
    end
    
    _userid = current_admin_user.id
    @tweets = Tweet.where(userid: _userid).all
    _followidlist.each do |fi|
      @tweets += Tweet.where(userid: fi.followuserid).all
    end
    #_followidlistが空だと.sort!でエラー(tweetsは空でもないのに謎
    #そもそもsortするの時間かかるからOR使ってtweets取得したい
    if _followidlist.exists? then @tweets.sort! end
    #  redirect_to '/tweets/show/' + _username
  end

  def show
    ##↓ エラーページに飛ぶようにした
    ##存在しないユーザのページは表示しないように(関数テスト)(理想的にはエラーページに飛ばす
    #if existpage(params[:username]) == false then 
    #  redirect_to '/tweets/index'
    #  return 
    #end
    #ページのユーザのuserid取得
    _pageuserid = AdminUser.where(username: params[:username])[0].id
    #(見ているページのユーザが)followしてるすべてのユーザ情報一覧取得
    _pageuserfollowidlist = Follow.where(userid: _pageuserid)
    @follows = []
    _pageuserfollowidlist.each do |fi|
      @follows.push(AdminUser.find(fi.followuserid))
    end

    #followしているかを@followedで管理(view側で使う
    if Follow.exists?(:userid => current_admin_user.id, :followuserid => _pageuserid) then
      @followed = true;
    else
      @followed = false;
    end
    #自分のtweet全入手
    _userid = AdminUser.where(username: params[:username]);
    @tweets = Tweet.where(userid: _userid).all

    #全ユーザのuserid取得(テスト用)
    @AllUsers = AdminUser.all
  end

  def new
#TO DO : sql injectionの対処
#他ユーザのnewはリンクつなげてもつながらないように
#params[:username]をcurrent_admin_user.usernameにしてもいいかも
    if params[:username] != current_admin_user.username then
      redirect_to '/tweets/show/' + params[:username]
    end
  end

  def create_follow
    @follow = Follow.new
    @follow.userid = current_admin_user.id
#要素ひとつだけ抜き出す方法が知りたい
#_fui = (AdminUser.find(username: params[:username])).idみたいに書きたい
    _followuserid = AdminUser.where(username: params[:username])
    @follow.followuserid = _followuserid[0].id
    @follow.save
    redirect_to '/tweets/show/' + params[:username]
  end

  def remove_follow
    _followuserid = AdminUser.where(username: params[:username])
    _followid = Follow.where(userid: current_admin_user.id).where(followuserid: _followuserid[0].id)
    Follow.delete(_followid[0].id)
    redirect_to '/tweets/show/' + params[:username]
  end

  def create
    @tweet = Tweet.new
    @tweet.title = params[:tweet][:title]
    @tweet.content = params[:tweet][:content]
    @tweet.username = params[:username]
    @tweet.userid = current_admin_user.id
    @tweet.save
    redirect_to '/tweets/show/' + params[:username]
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end
end
