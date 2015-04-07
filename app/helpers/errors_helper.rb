module ErrorsHelper
  class ActionView::Helpers::FormBuilder
    # http://stackoverflow.com/a/2625727/1935918
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::FormOptionsHelper

    def error_class column
      column = column.to_sym
      return '' if @object.errors.messages[column].nil?
      if @object.errors.messages[column].length > 0
        return 'has-error'
      end
    end

    def error_message column
      column = column.to_sym
      return '' if @object.errors.messages[column].nil?
      return @object.errors.messages[column].first
    end
  end

end