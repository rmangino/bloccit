module ModelHelper
  include ApplicationHelper

  # Create instance methods of the form markdown_{attribute}. For example:
  # markdown_title (which return an html string from a markdown string for
  # the current value of the title attribute).
  #
  # Example call: add_markdown_to_html_methods_for_class_attributes(Post, [:title, :body])
  def add_markdown_to_html_methods_for_class_attributes(klass, attributes)
    attributes.each do |attribute|
      klass.class_eval do
        define_method :"markdown_#{attribute}" do
          val = instance_eval  "#{attribute}"
          markdown_to_html(val)
        end
      end
    end
  end

end