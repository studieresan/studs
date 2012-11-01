module DefinitionListHelper
  def attribute_definition(term, value)
    content_tag(:dt, t_attribute(term) + ':', :class => term) +
      content_tag(:dd, value)
  end
end
