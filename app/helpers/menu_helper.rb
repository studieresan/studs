module MenuHelper
  # Combined setter and getter
  def active_menu(id = nil)
    @active_menu = id.to_sym if id
    @active_menu
  end
end
