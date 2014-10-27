module SessionsHelper
  def current_user
    user = nil
    user = User.find_by_remember_token!(cookies[:ecomm_app_remember_token]) if cookies[:ecomm_app_remember_token]
  end

  def logged_in?
    cookies[:ecomm_app_remember_token]
  end

  def isAdmin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def isLoggedIn
    unless logged_in?
      cookies["url"] = request.url
      redirect_to signin_path
    end
  end

  def signin_user(user)
    cookies[:ecomm_app_remember_token] = user.remember_token
  end
end
