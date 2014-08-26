class AdminUsersController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
  end 
  def following
		@pageuser = AdminUser.find(params[:id])
    @followeds = @pageuser.followed_admin_users
  end
  def followers
    @pageuser = AdminUser.find(params[:id])
    @followers = @pageuser.follower_admin_users
  end 
  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end 
end

