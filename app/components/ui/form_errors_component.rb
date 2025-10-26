module Ui
  class FormErrorsComponent < ViewComponent::Base
    def initialize(object:, **html_options)
      @object = object
      @html_options = html_options
    end

    def call
      return unless @object.errors.any?

      content_tag(:div, **@html_options, class: classes) do
        safe_join([
          content_tag(:h2, error_title),
          content_tag(:ul, class: "list-disc ml-6") do
            safe_join(error_messages)
          end
        ])
      end
    end

    private

    def classes
      class_names(
        "bg-red-50 text-red-500 px-3 py-2 font-medium rounded-md mt-3",
        @html_options[:class]
      )
    end

    def error_title
      "#{pluralize(@object.errors.count, "error")} prohibited this #{@object.model_name.human.downcase} from being saved:"
    end

    def error_messages
      @object.errors.map do |error|
        content_tag(:li, error.full_message)
      end
    end

    def pluralize(count, singular)
      count == 1 ? "#{count} #{singular}" : "#{count} #{singular}s"
    end
  end
end
