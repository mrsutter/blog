module AuthHelper
  def sign_in(user, remember_user = false)
    if remember_user
      cookies.signed[:user_id] = {
        value: user.id,
        expires: session_ttl.seconds.from_now
      }
    else
      cookies.signed[:user_id] = user.id
    end
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    cookies.delete(:user_id)
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  def authenticate_user!
    redirect_to new_user_session_path unless signed_in?
  end

  def authenticate_admin!
    return true if signed_in? && current_user.admin?
    redirect_to new_user_session_path
  end

  private

  def session_ttl
    Settings.session.ttl
  end
end
