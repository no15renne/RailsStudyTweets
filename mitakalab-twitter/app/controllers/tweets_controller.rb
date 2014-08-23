class TweetsController < ApplicationController
before_filter :authenticate_admin_user!

  def index
    #followしてるすべてのユーザ情報一覧取得
    _followidlist = Follow.where(userid: current_admin_user.id) 
    @follows = []	#宣言してないと怒られる（もうちょい綺麗にしたい
    _followidlist.each do |fi|
      @follows.push(AdminUser.find(fi.followuserid))
    end
    
    @tweets = Tweet.where(userid: current_admin_user.id)
    _followidlist.each do |fi|
      @tweets += Tweet.where(userid: fi.followuserid)
    end
    #_followidlistが空だと.sort!でエラー(tweetsは空でもないのに謎
    #そもそもsortするの時間かかるからOR使ってtweets取得したい
    if _followidlist.exists? then @tweets.sort! end
    #  redirect_to '/tweets/show/' + _username
  end

  def show
		@pageuser = AdminUser.find(params[:id])
    #AdminUser.where(username: params[:username])[0].id
    #(見ているページのユーザが)followしてるすべてのユーザ情報一覧取得
    _pageuserfollowidlist = Follow.where(userid: @pageuser.id)
    @follows = []
    _pageuserfollowidlist.each do |fi|
      @follows.push(AdminUser.find(fi.followuserid))
    end

    #followしているかを@followedで管理(view側で使う
    if Follow.exists?(:userid => current_admin_user.id, :followuserid => @pageuser.id) then
      @followed = true;
    else
      @followed = false;
    end
    #自分のtweet全入手
    @tweets = Tweet.where(userid: @pageuser.id)

    #全ユーザのuserid取得(テスト用)
    @AllUsers = AdminUser.all
  end

  def new
#routeで'tweet/new'でアクセスするためCurrentAdminUserの情報を使う
#他人のnewTweetはできない
  end

  def create_follow
    @follow = Follow.new
    @follow.userid = current_admin_user.id
		@follow.followuserid = params[:id].to_i
    @follow.save
    redirect_to '/tweets/' + params[:id]
  end

  def remove_follow
    _followuserid = params[:id].to_i
    _followid = Follow.find_by(userid: current_admin_user.id, followuserid: _followuserid)
    Follow.delete(_followid.id)
    redirect_to '/tweets/' + params[:id]
  end

  def create
    @tweet = Tweet.new
    @tweet.title = params[:tweet][:title]
    @tweet.content = params[:tweet][:content]
    @tweet.username = current_admin_user.username
    @tweet.userid = current_admin_user.id
    @tweet.save
    redirect_to '/tweets/' + current_admin_user.id.to_s
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end
end
