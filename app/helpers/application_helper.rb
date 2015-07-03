module ApplicationHelper

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  # Convert a string containing markdown into its HTML equivalent.
  # WARNING: possibly insecure
  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

  def up_vote_link_classes(user, post)
    upvoted = (user.voted(post) && user.voted(post).up_vote?)
    upvoted ? 'voted' : ''
  end

  def down_vote_link_classes(user, post)
    upvoted = (user.voted(post) && user.voted(post).down_vote?)
    upvoted ? 'voted' : ''
  end

  def my_name
    "Reed Mangino"
  end
end
