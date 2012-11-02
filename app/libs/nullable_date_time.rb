module NullableDateTime
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    # Define a virtual boolean attribute which can be used to control an
    # underlying date/datetime attribute.
    def nullable_datetime(attribute, boolean_attribute = nil, disables = false)
      unless boolean_attribute
        boolean_attribute = "is_#{attribute.to_s.sub(/_at\z/, '')}"
      end

      attribute_setter = "#{attribute}=".to_sym
      attribute = attribute.to_sym
      getter = boolean_attribute.to_sym
      setter = "#{getter}=".to_sym

      send(:define_method, getter) do
        if disables
          send(attribute).blank?
        else
          send(attribute).present?
        end
      end

      send(:define_method, setter) do |bool|
        bool = %w(true 1 yes).include?(bool.to_s)
        if bool
          send(attribute_setter, Time.now) unless send(getter)
        else
          send(attribute_setter, nil)
        end
        instance_variable_set("@#{boolean_attribute}", bool)
      end

      # Update attribute with nil value if boolean is false when necessary
      clear_method_name = "clear_#{attribute}_unless_#{boolean_attribute}".to_sym
      send(:after_initialize, clear_method_name)
      send(:before_save, clear_method_name)
      send(:define_method, clear_method_name) do
        send(attribute_setter, nil) if instance_variable_get("@#{boolean_attribute}") == disables
      end
    end # nullable_datetime
  end
end
