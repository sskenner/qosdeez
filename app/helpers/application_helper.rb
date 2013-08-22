module ApplicationHelper

  def button_name
    if @post.new_record? ? 'Create Post' : 'Edit Post'
    end
  end
end
