class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :require_authentication
  helper_method :current_user, :signed_in?

  private

  def require_authentication
    redirect_to new_session_path unless signed_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    current_user.present?
  end
end
