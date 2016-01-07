include Twitter::Autolink

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.nil? || page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Replaces tags with links in given text while also making text html safe.
  def auto_link_tags(text = "")
    auto_link_hashtags(CGI::escapeHTML(text), hashtag_class: "tag",
                            hashtag_url_base: "/tags/")
  end
end
