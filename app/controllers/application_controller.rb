class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Get default locale from palams
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Override default_url_options
  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  protected

  # Add Strong parameters
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
