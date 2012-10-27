module DefinitionListHelper
  def attribute_definition(term, value)
    content_tag(:dt, I18n.t("attributes.#{term}") + ':', :class => term) +
      content_tag(:dd, value)
  end
end
