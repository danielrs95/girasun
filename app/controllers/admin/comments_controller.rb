class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.includes(:book).order(created_at: :desc)
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: 'Comentario actualizado con éxito.'
    else
      redirect_to admin_comments_path, alert: 'Error al actualizar el comentario.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:status)
  end
end
