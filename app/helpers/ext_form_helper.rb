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
    html_options_tags = %w(collection_check_boxes collection_radio_buttons) + 
              %w(collection_select date_select datetime_select) + 
              %w(grouped_collection_select select time_select time_zone_select)

    helpers.each do |name|
      # Normal tag generators (without labels)
      define_method(name) do |field, *args| #{{{
        opts = args.last.is_a?(Hash) ? args.pop : {}
        #Add html options if this tag type can have that
        html_opts = {}
        if html_options_tags.include?name and args.last.is_a?(Hash)
          html_opts = opts
          opts = args.pop
        end
        classes = [] # css classes for field

        # Include explicitly specified css classes
        if opts.include?(:class)
          classes += opts[:class].is_a?(Array) ? opts[:class] : opts[:class].to_s.split(' ')
        elsif html_opts.include?(:class)
          classes += html_opts[:class].is_a?(Array) ? html_opts[:class] : html_opts[:class].to_s.split(' ')
        end

        # Add field name and type class
        unless opts.delete(:limit_classes)
          classes << css_class_for_name(name)
          classes << 'disabled' if opts.include?(:disabled) && opts[:disabled]
        end

        unless %w(check_box radio_button).include?name
          classes << 'form-control'
        end
        if %w(date_select).include?name
          classes << 'form-control-inline'
        end

        # Include suggestions data if specified
        # Can either be a symbol for a class method which can be called,
        # a JSON compatible string or true, in which case the suggestions will
        # be retrieved from the corresponding column in the database.
        if opts.include?(:suggest)
          data = opts.delete(:suggest)
          classes.delete 'form-control'
          if data == true
            data = suggestion_data_for(field) 
          elsif data.is_a?(Symbol)
            data = @object.class.send(data)
          end
          opts['data-suggestions'] = data.is_a?(String) ? data : data.to_json
        end

        # Check errors
        object = @template.instance_variable_get("@#{@object_name.to_s.sub(/\[.+/, '')}")
        classes << 'error' if !object.nil? && 
            object.kind_of?(ActiveRecord::Base) && !object.errors[field.to_sym].empty?

        # CSS class string
        class_string = classes.uniq.join(' ')
        if html_options_tags.include?name
          html_opts[:class] = class_string
          html_opts.delete(:class) if html_opts[:class].blank?
        else
          opts[:class] = class_string
          opts.delete(:class) if opts[:class].blank?
        end

        # Call the parent field generator
        args << opts
        unless html_opts.blank?
          args << html_opts
        end
        super(field, *args)
      end #}}}

      # Field row wrapper with label, container and error message included
      define_method(name + '_row') do |field, *args| #{{{
        opts = args.last.is_a?(Hash) ? args.last : {}
        classes = %w(input) # css classes for container element
        classes << 'form-group'
        classes << opts.delete(:row_class) if opts.include?(:row_class)

        # Include classes describing the actual field name and type
        classes << css_class_for_name(name)
        classes << field.to_s
        classes << 'disabled' if opts.include?(:disabled) && opts[:disabled]
        # Do not include these in the field as well
        opts[:limit_classes] = true

        label_opts = {}
        label_opts[:class] = 'col-sm-4 col-xs-12 control-label'

        error = error_on(field)

        # Include error message
        if label_opts[:title] = error
          label_opts[:class] += ' error'
          classes << 'error'
        end


        # Make a label for the input row
        label_tag = label(field, opts.delete(:label), label_opts) #Add classes ("col-sm-4", "col-xs-12", "control-label")

        #Make the actual form element tag using the corresponding helper method
        input_tag = send(name.to_sym, field, *args)

        # Append hint if specified (replaced with error if present)
        if error && !opts.delete(:hide_error)
          input_tag += error_message(error)
        elsif opts[:hint]
          hint = opts.delete(:hint)
          input_tag += hint(hint == true ? field : hint)
        end

        field_html = @template.content_tag(:div, input_tag, :class => ["col-sm-8", "col-xs-12"])

        output = label_tag + ' ' + field_html

        @template.content_tag(:div, output, :class => classes.join(' '))
      end #}}}
    end

    # Returns a check box / radio button contained within a label.
    %w(check_box radio_button).each do |name| #{{{
      define_method("#{name}_label") do |field, *args|
        content = "#{send(name.to_sym, field, *args)} #{i18n_text(:attributes, field)}"
        label(field, content.html_safe, :class => "inline #{name}")
      end
    end #}}}

    # Override label generation with custom i18n lookup.
    def label(field, text = nil, options = {}, &block)
      text ||= i18n_text(:attributes, field)
      @template.label(@object_name, field, text, objectify_options(options), &block)
    end

    # Returns a field hint text. The hint text is localized if passed a field
    # name symbol, otherwise the text is output as is.
    def hint(field)
      field = i18n_text(:hints, field) unless field.is_a?(String)
      field.gsub!(/(\r\n|\r|\n)/, '<br />')
      @template.content_tag(:p, field.html_safe, :class => :'help-block')
    end

    # Returns error text for a field, if present.
    def error_message(field)
      field = error_on(field) if field.is_a?(Symbol)
      @template.content_tag(:p, field, :class => [:error, :'has-error', :'help-block'])
    end

    # Submit tag which also classifies the input by the input name.
    def submit(value = nil, opts = {})
      value, opts = nil, value if value.is_a?(Hash)
      value ||= object ? (object.persisted? ? :update : :create) : :submit
      if value.is_a?(Symbol)
        value = I18n.t("helpers.submit.#{value}", default: "#{value.to_s.humanize}")
      end
      opts[:name] ||= :commit
      opts[:class] = Array(opts[:class]) << opts[:name]
      opts[:class] << [:btn, :'btn-default btn-primary']
      @template.submit_tag(value, opts)
    end

    private

    def i18n_text(type, field)
      I18n.t("#{type}.#{@object_name}.#{field}",
        default: :"#{type}.defaults.#{field}")
    end

    def suggestion_data_for(attribute)
      @object.class.uniq.pluck(attribute).to_a.reject(&:blank?)
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
