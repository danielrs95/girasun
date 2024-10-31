class ApplicationController < ActionController::Base
  private

  def require_admin
    return if current_user&.admin?

    flash[:alert] = 'You must be an administrator to perform this action.'
    redirect_to root_path
  end
end
