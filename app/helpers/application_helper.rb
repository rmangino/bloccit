module ApplicationHelper

  def my_name
    "Reed Mangino"
  end

  # Allows the replacement of:
  #
  #   <%= f.label :description %>
  #   <%= f.text_field :description %>
  #
  # with:
  #
  #   <%= f.text_field :description %>
  #
  # Use with form_for:
  #
  #    <%= form_for xxx, builder: ApplicationHelper::LabellingFormBuilder do |f| %>
  class LabellingFormBuilder < ActionView::Helpers::FormBuilder
    def text_field(attribute, options={})
      label(attribute) + super
    end
  end

end
