module Ui
  class AlertComponent < ViewComponent::Base
    def initialize(type: :success, message: nil, **html_options)
      @type = type
      @message = message
      @html_options = html_options
    end

    def call
      return unless @message.present?

      content_tag(:div, @message, **@html_options, class: classes)
    end

    private

    def classes
      class_names(
        base_classes,
        type_classes,
        @html_options[:class]
      )
    end

    def base_classes
      "py-2 px-3 mb-5 font-medium rounded-md inline-block"
    end

    def type_classes
      case @type
      when :success
        "bg-green-50 text-green-500"
      when :error
        "bg-red-50 text-red-500"
      when :warning
        "bg-yellow-50 text-yellow-500"
      when :info
        "bg-blue-50 text-blue-500"
      end
    end
  end
end
