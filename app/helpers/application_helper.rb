module ApplicationHelper

  def button_name
    if @post.new_record? ? 'Create Post' : 'Edit Post'
    end
  end

  def fix_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end

  def display_date(date)
    if logged_in?
      date = date.in_time_zone(current_user.time_zone)
    end
    date.strftime('%B %d, %Y at %I:%M %p %Z')
  end

  def avatar_url(user)
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end
end
