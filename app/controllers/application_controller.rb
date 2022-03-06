class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user! 
  skip_before_action :authenticate_user!, if: :devise_controller?, only: [:new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def listing_items
    response = Faraday.get('https://d2dcafd8b62eqh.cloudfront.net/extra/menu.json')
    render json: response.body
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

end
