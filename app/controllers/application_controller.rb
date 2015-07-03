class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  # How to have Devise route to a specific path upon a successful login.
  # https://github.com/plataformatec/devise/wiki/How-To%3A-Redirect-to-a-specific-page-on-successful-sign-in-and-sign-out
  def after_sign_in_path_for(resource)
    topics_path
  end

protected

  # Add name to the list of parameters accepted by devise during sign up.
  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

end
