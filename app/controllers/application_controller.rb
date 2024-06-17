class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!
  protect_from_forgery prepend: true

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  add_flash_types :info, :warning, :success, :error

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirm])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: request.referer || root_path)
  end
end
