class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit ]

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @new_book = Book.new
    @new_book_comment = BookComment.new
    
    ##閲覧数カウント機能用/詳細ページを開くたびにカウント加算(inpressionistの場合)
    impressionist(@book, nil, unique: [:ip_address]) 
    
    #閲覧数カウント機能/inpressionistを利用しない場合。
    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end
    
  end

  def index
    @new_book = Book.new
    @books = Book.includes(:favorited_users).sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
