class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private
  def authenticate!
    return if current_user

    session[:current_url] = request.url
    redirect_to new_session_path
  end

  def check_authenticated
    if session.keys.include?('user')
      user = User.find session[:user]['id']
      if user.email == session[:user]['email']
        return user
      end
    end

    return false
  end

  def current_user
    @current_user ||= check_authenticated 
  end
end
