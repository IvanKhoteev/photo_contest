# Main controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def autorization
    if current_user.blank?
      render nothing: true, status: 401
    end
  end

  helper_method :current_user
  helper_method :autorization
end
