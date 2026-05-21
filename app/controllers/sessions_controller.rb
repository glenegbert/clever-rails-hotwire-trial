class SessionsController < ApplicationController
  skip_before_action :require_authentication

  def new; end

  def create
    user = User.find_by(email: params[:email]&.downcase)
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
