class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    #ユーザーがデータベースにあり、かつ、認証に成功した場合にのみ
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:primary] = "Login Successfull!!"
      redirect_to user
    else
      flash.now[:warning] = "Invalid Credentials"
      render "new"
    end
  end

  def destroy
    log_out
    @current_user = nil
    redirect_to root_url
  end
end
