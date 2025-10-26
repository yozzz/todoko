module Ui
  class ButtonComponent < ViewComponent::Base
    def initialize(variant: :primary, size: :md, full_width_mobile: false, **html_options)
      @variant = variant
      @size = size
      @full_width_mobile = full_width_mobile
      @html_options = html_options
    end

    def call
      content_tag(tag_name, content, **@html_options, class: classes)
    end

    private

    def tag_name
      @html_options[:href] ? :a : :button
    end

    def classes
      class_names(
        base_classes,
        size_classes,
        variant_classes,
        responsive_classes,
        @html_options[:class]
      )
    end

    def base_classes
      "inline-block font-medium rounded-md cursor-pointer text-center"
    end

    def size_classes
      case @size
      when :sm then "px-2.5 py-1.5 text-sm"
      when :md then "px-3.5 py-2.5"
      when :lg then "px-4 py-3 text-lg"
      end
    end

    def variant_classes
      case @variant
      when :primary
        "bg-blue-600 hover:bg-blue-500 text-white"
      when :secondary
        "bg-gray-100 hover:bg-gray-50"
      when :danger
        "bg-red-600 hover:bg-red-500 text-white"
      end
    end

    def responsive_classes
      @full_width_mobile ? "w-full sm:w-auto" : ""
    end
  end
end
