class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action: :configure_permitted_devise_parameters, if: :devise_controller?

protected

  # Add name to the list of parameters accepted by devise during sign up.
  def configure_permitted_devise_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
