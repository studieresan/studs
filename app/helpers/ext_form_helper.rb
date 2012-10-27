module ExtFormHelper
  # Add custom ext_form_for and ext_fields_for methods which uses this form builder.
  %w(form_for fields_for).each do |meth|
    src = <<-end_src
      def ext_#{meth}(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.update(builder: ExtFormBuilder)
        #{meth}(object_name, *(args << options), &proc)
      end
    end_src
    module_eval src, __FILE__, __LINE__
  end

  class ExtFormBuilder < ActionView::Helpers::FormBuilder
    helpers = field_helpers +
              %w(date_select datetime_select time_select) +
              %w(collection_select select country_select time_zone_select) -
              %w(hidden_field label fields_for) # Don't decorate these

    helpers.each do |name|
      # Normal tag generators (without labels)
      define_method(name) do |field, *args|
        opts = args.last.is_a?(Hash) ? args.pop : {}
        classes = [] # css classes for field

        # Include explicitly specified css classes
        if opts.include?(:class)
          classes += opts[:class].is_a?(Array) ? opts[:class] : opts[:class].to_s.split(' ')
        end

        # Add field name and type class
        unless opts.delete(:limit_classes)
          classes << css_class_for_name(name)
          classes << 'disabled' if opts.include?(:disabled) && opts[:disabled]
        end

        # Check errors
        object = @template.instance_variable_get("@#{@object_name.to_s.sub(/\[.+/, '')}")
        classes << 'error' if !object.nil? && 
            object.kind_of?(ActiveRecord::Base) && !object.errors[field.to_sym].empty?

        # Call the parent field generator
        opts[:class] = classes.uniq.join(' ')
        args << opts
        super(field, *args)
      end

      # Field row wrapper with label, container and error message included
      define_method(name + '_row') do |field, *args|
        opts = args.last.is_a?(Hash) ? args.last : {}
        classes = %w(input) # css classes for container element
        classes += opts.delete(:row_class) if opts.include?(:row_class)

        # Include classes describing the actual field name and type
        classes << css_class_for_name(name)
        classes << field.to_s unless name == 'submit'
        classes << 'disabled' if opts.include?(:disabled) && opts[:disabled]
        # Do not include these in the field as well
        opts[:limit_classes] = true

        label_opts = {}

        error = error_on(field)

        # Include error message
        if label_opts[:title] = error
          label_opts[:class] = 'error'
          classes << 'error'
        end

        field_html = @template.content_tag(:span, send(name.to_sym, field, *args), :class => :wrap)

        # Place inputs for radio buttons and check boxes inside label
        if %w(check_box radio_button).include?(name)
          output = label(field, opts.delete(:label), label_opts) do
            "#{field_html} #{i18n_field_name(field)}".html_safe
          end
        else
          output = label(field, opts.delete(:label), label_opts) + ' ' + field_html
        end

        # Append hint if specified (replaced with error if present)
        if opts[:hint]
          hint = opts.delete(:hint)
          text = error ? error : hint.is_a?(String) ? hint : i18n_hint_text(field)
          output += (' ' + @template.content_tag(:span, text, :class => error ? :error : :hint)).html_safe
        end

        @template.content_tag(:div, output, :class => classes.join(' '))
      end
    end

    private

    def i18n_field_name(field)
      I18n.t("attributes.#{field}")
    end

    def i18n_hint_text(field)
      I18n.t("hints.#{@object_name}.#{field}")
    end

    def object
      # @template.instance_variable_get("@#{@object_name.to_s.sub(/\[.+/, '')}")
      @object ||= @template.instance_variable_get("@#{@object_name}")
    end

    def error_on(field)
      return nil if object.nil? || !object.respond_to?(:errors)
      errors = object.errors[field.to_sym]
      return nil if !errors || errors.empty?
      errors.is_a?(Array) ? errors.first : errors
    end

    def css_class_for_name(name)
      name = name.sub(/_(field|select)\Z/i, '')
      return case name
      when 'password' then 'text'
      when 'check_box' then 'check'
      when 'radio_button' then 'radio'
      when 'collection' then 'select'
      else name
      end
    end
  end
end
