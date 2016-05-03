class Web::User::SessionsController < Web::User::ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    redirect_to root_path if signed_in?
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      sign_in(user, remember_user?)
      redirect_to root_path
    else
      flash[:error] = flash_translate(:wrong_pair)
      redirect_to new_user_session_path
    end
  end

  def destroy
    sign_out
    redirect_to new_user_session_path
  end

  private

  def session_params
    @session_params ||= params[:user_session]
  end

  def remember_user?
    session_params[:remember_me].present?
  end
end
