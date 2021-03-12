class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to controller: :books, action: :show, id: @book.id
    if not @book.save
      flash[:notice] = "Book was error created."
      redirect_to controller: :books, action: :index
    end
    else
      @books = Book.all
      render controller: :books, action: :index
    end
  end


  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to controller: :books, action: :show, id: @book.id
    end
    if not @book.update(book_params)
      flash[:notice] = "Book was error updated."
      redirect_to books_path
    end
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    if @book.destroy
      flash[:notice] = "Book was successfully destroyed."# データ（レコード）を削除
      redirect_to books_path# 投稿一覧画面へリダイレクト
    end
    if not @book.destroy
      flash[:notice] = "Book was error destroyed."
      redirect_to controller: :books, action: :index
    end
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
