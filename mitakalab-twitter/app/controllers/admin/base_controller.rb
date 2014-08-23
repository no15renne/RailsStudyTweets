class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
    redirect_to '/tweets'
  end
  private
  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end
end
