class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [attachment_attributes: [:id, :image, :_destroy]])
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :email, :password, :password_confirmation, attachment_attributes: [:id, :image, :_destroy]])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :full_name
  end

  def not_found
    redirect_to root_path, alert: ' Record Not Found, Try again'
  end
end
