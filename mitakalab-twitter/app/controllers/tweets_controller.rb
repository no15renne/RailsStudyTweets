class TweetsController < ApplicationController
before_filter :authenticate_admin_user!

  def index
    #followしてるすべてのユーザ情報一覧取得
		#AdminUserとTweetも1:多に紐付けたい
    @tweets = Tweet.where(userid: current_admin_user.id)
    current_admin_user.relationships.each do |f|
      @tweets += Tweet.where(username: f.followed.username)
    end
    if current_admin_user.relationships.exists? then @tweets.sort! end
  end

  def show
		@pageuser = AdminUser.find(params[:id])
    #(見ているページのユーザが)followしてるすべてのユーザ情報一覧取得
		@followeds = @pageuser.relationships
		@followers = @pageuser.reverse_relationships

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
		_user = AdminUser.find(params[:id])
		if current_admin_user.following?(_user) == false then
			current_admin_user.follow!(_user)
		end
    redirect_to '/tweets/' + params[:id]
  end

  def remove_follow
		_user = AdminUser.find(params[:id])
		if current_admin_user.following?(_user) == true then
    	current_admin_user.unfollow!(AdminUser.find(params[:id]))
    end
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
