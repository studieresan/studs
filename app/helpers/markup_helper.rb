module MarkupHelper
  include ActsAsTaggableOn::TagsHelper

  # Definition list term/value generator.
  def attribute_definition(term, value)
    content_tag(:dt, t_attribute(term) + ':', :class => term) +
      content_tag(:dd, value)
  end

  # Returns a link to the specific adress with a translated action text.
  # A link title (specified as i18n id) may be included after the link
  # parameter, as well as/or any additional css classes (other than 'action')
  # which should be applied.
  def action_link(action, link, *classes)
    args = { href: url_for(link) }

    if classes.first.is_a?(String)
      args[:title] = I18n.t(classes.shift)
    end

    unless action.is_a?(String)
      classes << action
      action = I18n.t("actions.#{action}")
    end

    # Include link title for actions where only the icon is visible 
    args[:title] ||= action if classes.include?(:icon)

    args[:class] = (%w(action) + classes).join(' ')
    content_tag(:a, action, args)
  end
end
