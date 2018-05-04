class Admin::BaseController < ApplicationController
	before_filter :authenticate_admin_user!
  def index
  	#redirect_to '/tweets'
	end
end
