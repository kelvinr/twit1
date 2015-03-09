module ApplicationHelper
  def auto_links(str)
    str = link_hashtag(str)
    str = link_mentions(str)
  end

  def link_hashtag(str)
    str.gsub(/#(\w+)/, "<a href='/hashtags/\\1'>#\\1</a>").html_safe
  end

  def link_mentions(str)
    str.gsub(/@(\w+)/, "<a href='/\\1'>@\\1</a>").html_safe
  end
end
