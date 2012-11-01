module I18nHelper
  def t_attribute(*scope, attribute)
    default = scope.empty? ? nil : "attributes.defaults.#{attribute}"
    scope = scope.empty? ? 'defaults' : scope.join('.')
    I18n.t("attributes.#{scope}.#{attribute}", default: default)
  end

  def t_masters(name)
    I18n.t("values.masters.#{name}", default: name.upcase)
  end

  def t_model_action(model_name = nil, action = nil)
    model_name ||= controller_name.singularize
    action ||= action_name
    "#{I18n.t("actions.#{action}")} #{I18n.t("models.a.#{model_name}")}"
  end
end
