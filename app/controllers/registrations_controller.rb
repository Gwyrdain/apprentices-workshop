class RegistrationsController < Devise::RegistrationsController

  def update    
    @user = User.find(current_user.id)
    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(account_update_params)
    else
      params[:user].delete(:current_password)   
      @user.update_without_password(account_update_params_no_password)
    end
  
    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end


  private

  def sign_up_params
    params.require(:user).permit( :first_name, :last_name, :email, :password,
                                  :password_confirmation, :time_zone)
  end

  def account_update_params
    params.require(:user).permit( :first_name, :last_name, :email, :password,
                                  :password_confirmation, :current_password,
                                  :time_zone, :collapse_panels, :use_rulers)
  end

  def account_update_params_no_password
    params.require(:user).permit( :time_zone, :collapse_panels, :use_rulers)
  end
  
  def needs_password?(user, params)
    (params[:user].has_key?(:email) && user.email != params[:user][:email]) || !params[:user][:password].blank?
  end

end