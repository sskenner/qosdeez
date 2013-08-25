module ApplicationHelper

  def button_name
    if @post.new_record? ? 'Create Post' : 'Edit Post'
    end
  end

  def fix_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end
end
