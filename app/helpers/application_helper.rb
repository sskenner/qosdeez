module ApplicationHelper

  def button_name
    if @post.new_record? ? 'Create Post' : 'Edit Post'
    end
  end

  def fix_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end

  def display_date(date)
    date.strftime('%B %d, %Y at %I:%M %p')
  end
end
