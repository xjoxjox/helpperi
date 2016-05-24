module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    parameters = [:first_name, :last_name, :personal_code, :phone_number, :address, :zip_code, :city, :description]
    devise_parameter_sanitizer.for(:sign_up) << parameters
    devise_parameter_sanitizer.for(:account_update) << parameters
  end

end

DeviseController.send :include, DevisePermittedParameters