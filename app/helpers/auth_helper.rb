module AuthHelper
  def admin?
    logged_in? && current_user.admin?
  end

  def student?
    logged_in? && current_user.student?
  end

  def organization?
    logged_in? && current_user.organization?
  end
end
