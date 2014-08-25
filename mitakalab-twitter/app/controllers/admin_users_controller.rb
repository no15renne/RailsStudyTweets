class AdminUsersController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
    #redirect_to '/tweets'
  end 
  def following
		_pageuser = AdminUser.find(params[:id])
    @followeds = _pageuser.followed_admin_users
  end
  def followers
    _pageuser = AdminUser.find(params[:id])
    @followers = _pageuser.follower_admin_users
  end 
  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end 
end

