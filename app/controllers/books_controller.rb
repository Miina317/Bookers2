class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @user = @book.user
      @books = Book.all
      render :index
    end
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @books = Book.all
    
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
  @book = Book.find(params[:id])
  @user = current_user
  unless @user.id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
def destroy
  @book = Book.find(params[:id])
  if @book.user_id == current_user.id
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  else
    redirect_to books_path
  end
end

    private
    def book_params
      params.require(:book).permit(:title, :body, :profile_image, :name)
    end
end