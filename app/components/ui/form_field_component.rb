module Ui
  class FormFieldComponent < ViewComponent::Base
    def initialize(object_name:, method:, object: nil, label: nil, field_type: :text_field, **html_options)
      @object_name = object_name
      @method = method
      @object = object
      @label = label || method.to_s.humanize
      @field_type = field_type
      @html_options = html_options
    end

    def call
      content_tag(:div, class: "mb-4") do
        safe_join([
          label_tag,
          field_tag,
          error_messages
        ])
      end
    end

    private

    def label_tag
      content_tag(:label, @label, for: field_id, class: "font-medium text-sm")
    end

    def field_tag
      send(:"#{@field_type}_tag", field_name, field_value, **@html_options, class: field_classes, id: field_id)
    end

    def field_name
      "#{@object_name}[#{@method}]"
    end

    def field_value
      @object&.public_send(@method)
    end

    def field_id
      "#{@object_name}_#{@method}"
    end

    def field_classes
      base = "block shadow-sm rounded-md border px-3 py-2 mt-2 w-full"
      state = has_errors? ? "border-red-400 focus:outline-red-600" : "border-gray-400 focus:outline-blue-600"

      class_names(base, state, @html_options[:class])
    end

    def has_errors?
      @object&.errors&.[](@method)&.any?
    end

    def error_messages
      return unless has_errors?

      content_tag(:div, class: "bg-red-50 text-red-500 px-3 py-2 font-medium rounded-md mt-3") do
        @object.errors[@method].join(", ")
      end
    end
  end
end
