class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
#    devise_parameter_sanitizer.for(:acconut_update) << :username
  end

#ifが余計?
#  if !Rails.env.development?
    rescue_from Exception,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
#  end

  public
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end
  
  def render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e
    
    if request.xhr?
      render json: { error: '404 error' }, status: 404
    else
      render file: Rails.root.join('/errors/error_404.html'), status: 404, layout: false, content_type: 'text/html'
    end
  end
  
  def render_500(e = nil)
    logger.info "Rendering 500 with exception: #{e.message}" if e
    
    if request.xhr?
      render json: { error: '500 error' }, status: 500
    else
      render file: '/errors/error_500.html', status: 500, layout: false, content_type: 'text/html'
    end
  end
  
end

  
