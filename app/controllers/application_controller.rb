class ApplicationController < ActionController::Base

  expose(:flash_alerts) { FlashDecorator.decorate_collection filtered_flash }
  protect_from_forgery with: :exception

  include StaticRoutes
  before_filter :login_required
  helper_method :logged_in?, :current_user

  private

  def login_required
    redirect_to login_path unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user ||= begin
      if session[:user_id] && (user = User.find_by(id: session[:user_id]))
        UserDecorator.decorate(user)
      end
    end
  end

  def filtered_flash
    flash.select{ |f| f[1].is_a?(String) }
  end

end
