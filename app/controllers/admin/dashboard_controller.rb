class Admin::DashboardController < Admin::BaseController
  def index
    # Estadísticas u otra información para el dashboard
    @total_books = Book.count
    @total_comments = Comment.count
    @pending_comments = Comment.pending.count
  end
end