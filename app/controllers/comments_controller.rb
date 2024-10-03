class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.build(comment_params)
    @comment.status = :pending
    if @comment.save
      redirect_to @book, notice: 'Comentario enviado y en espera de aprobación.'
    else
      redirect_to @book, alert: 'Error al enviar el comentario.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
