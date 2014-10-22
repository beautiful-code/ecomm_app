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
end
