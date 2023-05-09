class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @profile_image = @user.profile_image
    
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
    if  @user == current_user
      render "edit"
    else
        redirect_to user_path(current_user)
    end
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice]="You have updated user successfully."
       redirect_to user_path(current_user)
    else
       render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:introduction, :name, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end