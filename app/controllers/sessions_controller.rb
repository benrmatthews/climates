class SessionsController < ApplicationController

  skip_before_filter :login_required

  expose(:failure_reason) { params[:message].presence || 'unknown' }

  def create
    login.commence!
    redirect_to root_path
  end

  def failure
  end

  private

  def auth_info
    request.env['omniauth.auth'].to_hash
  end

  def user_params
    raw_params = ActionController::Parameters.new(auth_info['info'])
    raw_params.permit(:first_name, :last_name, :email)
  end

  def login
    LogUserIn.new(session, user_params)
  end

  def failure_message
    params[:message].presence || 'unknown'
  end

end
