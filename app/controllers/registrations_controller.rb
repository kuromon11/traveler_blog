class RegistrationsController < Devise::RegistrationsController

  
  protected
  
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :image, :gender_id, :residence_id, :email])
  end



  protected
  #アップデート時にパスワードの入力を取り除く
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end