class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  def google_oauth2
    callback_from :google_oauth2
  end

  # def failure
  #   redirect_to root_path
  # end

  private
  def callback_from(provider)
    provider = provider.to_s
    # APIから受け取ったレスポンスがrequest.env["omniauth.auth"]に入っている。モデルで処理を行う。
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted? #ユーザー情報が登録済みなので、新規登録ではなくログイン処理を行う
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else #ユーザー情報が未登録なので、新規登録画面へ遷移する
      print("persisted false")
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to  new_user_registration_url
    end
  end


  #別参考
  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"].except("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def twitter
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
  #   else
  #     session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end


end