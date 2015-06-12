class CallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
    else
      set_flash_message(:notice, :success, :kind => "You already have an account")
      redirect_to new_user_session
    end
  end

  alias_method :facebook,:all
  alias_method :google_oauth2, :all
  alias_method :linkedin,:all

end