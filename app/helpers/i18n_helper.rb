module I18nHelper
  # Returns a localized version of the provided attribute name.
  # Lookups are done in attributes.{scope}.{attribute}, falling back to
  # attributes.defaults.{attribute} if the former isn't defined.
  def t_attribute(*scope, attribute)
    default = scope.empty? ? nil : :"attributes.defaults.#{attribute}"
    scope = scope.empty? ? 'defaults' : scope.join('.')
    I18n.t("attributes.#{scope}.#{attribute}", default: default)
  end

  # Returns a localized version of the provided experience kind.
  def t_experience_kind(experience)
    I18n.t("values.experience_kind.#{experience}", default: experience.capitalize)
  end

  # Returns a localized action-model string.
  # The model name and action is guessed from controller name and action if
  # left unspecified.
  def t_model_action(model_name = nil, action = nil)
    model_name ||= controller_name.singularize
    action ||= action_name
    "#{I18n.t("actions.#{action}")} #{I18n.t("models.a.#{model_name}")}"
  end
end
