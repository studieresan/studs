module MarkupHelper
  # Definition list term/value generator.
  def attribute_definition(term, value)
    content_tag(:dt, t_attribute(term) + ':', :class => term) +
      content_tag(:dd, value)
  end

  def action_link(action, link, *classes)
    unless action.is_a?(String)
      classes << action
      action = I18n.t("actions.#{action}")
    end
    classes << 'action'
    content_tag(:a, action, href: url_for(link), :class => classes.join(' '))
  end
end
