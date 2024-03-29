class CallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect user
  end
  alias_method :google_oauth2, :all
  alias_method :linkedin,:all

end