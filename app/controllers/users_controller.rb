class UsersController < ApplicationController

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

end
