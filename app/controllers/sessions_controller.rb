class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:new, :create]
  before_action :check_current_url

  def new
    @user = User.new
  end

  def create
    user_authenticate_service = AuthenticateUser.new params[:user][:email], params[:user][:password]

    respond_to do |format|
      begin
        @user = user_authenticate_service.perform
        session[:user] = { id: @user.id, email: @user.email }
        
        format.html {redirect_to session[:current_url]}
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = 'Invalid email/password combination'
        format.html { render :new }
      end
    end
  end

  def destroy
    session.delete(:user)
    session.delete(:current_url)

    respond_to do |format|
      format.html { redirect_to new_session_path }
    end
  end

  private
  def check_current_url
    #session[:current_url] = root_url if session[:current_url].nil?
    session[:current_url] ||= root_url
  end

  def redirect_if_authenticated
    if current_user
      redirect_to root_url
    end
  end
end
