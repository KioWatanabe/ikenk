class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  

   protected

 	def edit
		super
　	end

	def update
		super
	end

	def after_sign_in_path_for(resource)
	  photos_path
	end


	private

	# def configure_permitted_parameters
	#   devise_parameter_sanitizer.for(:account_update) do |u|
	#     u.permit(:name, :email, :password, :password_confirmation, :current_password, :image)
	#   end
	# end
	def configure_permitted_parameters
    added_attrs = [ :username, :email, :password, :password_confirmation　]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
