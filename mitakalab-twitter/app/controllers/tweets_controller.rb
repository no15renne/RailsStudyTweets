class TweetsController < ApplicationController
before_filter :authenticate_admin_user!

  def index
    #followしてるすべてのユーザ情報一覧取得
		p 'current admin user is '
		p current_admin_user
    @tweets = current_admin_user.followedtweet
  end

  def show
    @pageuser = AdminUser.find(params[:id])
    #(見ているページのユーザの)followed, followersのユーザ情報取得
    @followeds = @pageuser.followed_admin_users
    @followers = @pageuser.follower_admin_users

    #自分のtweet全入手
    @tweets = @pageuser.tweets
    #@tweets = Tweet.where(admin_user_id: @pageuser.id)

    #全ユーザのuserid取得(URLでたどるのめんどくさいので)
    @AllUsers = AdminUser.all
  end

  def new
#routeで'tweet/new'でアクセスするためCurrentAdminUserの情報を使う
#他人のnewTweetはできない
  end
	#follows#createに書くべきかも
  def create_follow
		_user = AdminUser.find(params[:id])
    #二重に処理が起こらないようif(原理的には必要ないはず)
		if current_admin_user.following?(_user) == false then
			current_admin_user.follow!(_user)
		end
    redirect_to tweet_path(params[:id])
  end

  def remove_follow
		_user = AdminUser.find(params[:id])
		if current_admin_user.following?(_user) == true then
    	current_admin_user.unfollow!(AdminUser.find(params[:id]))
    end
    redirect_to tweet_path(params[:id])
  end

  def create
    @tweet = Tweet.new
    @tweet.title = params[:tweet][:title]
    @tweet.content = params[:tweet][:content]
    @tweet.username = current_admin_user.username
    @tweet.admin_user_id = current_admin_user.id
    @tweet.save
    redirect_to tweet_path(current_admin_user.id)
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end
end
