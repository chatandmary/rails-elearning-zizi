class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:primary] = "Created your account!!"
        redirect_to @user
      else
        render "new"
      end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])    
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:primary] = "Updated your profile"
        redirect_to @user
      else
        render "edit"
      end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:primary] = "User deleted!!"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Follower"
    @user  = User.find(params[:id])
    @users = @user.follower
    render 'show_follow'
  end

  private 
    # strong parameters
    def user_params
        params.require(:user).permit(:name,:email, :password, :password_confirmation)
    end

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
