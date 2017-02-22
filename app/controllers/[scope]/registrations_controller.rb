class [scope]::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.all
  end

  def edit
    @user = User.find(params[:id])
  end

 def update
   @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to user_show_path(@user)
  else
    render :edit
  end
 end
 
   protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :image)
  end

end
