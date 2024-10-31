class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

  def index
    @books = Book.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'El libro fue creado exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'El libro fue actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])

    Book.transaction do
      @book.comments.destroy_all
      @book.destroy
    end

    redirect_to books_path, notice: 'El libro ha sido eliminado exitosamente.'
  rescue ActiveRecord::InvalidForeignKey
    redirect_to books_path, alert: 'No se pudo eliminar el libro debido a registros asociados.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :year, :historic_context, :author_details)
  end
end
