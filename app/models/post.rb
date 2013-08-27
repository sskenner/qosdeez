class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User',
                       foreign_key: 'user_id'
  has_many :comments
  has_many :labels
  has_many :categories, through: :labels
  has_many :votes, as: :voteable

  validates :title, presence: true

  after_validation :generate_slug

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end

  def generate_slug
    self.slug = self.title.gsub(" ", "-").downcase
    @posts = Post.all

    @posts.each do |post|
      if self.slug == post.slug
        post = post.slug.chars
        last = post.pop
        if last.to_i == 0
          self.slug += "-1"
        else
          last = last.to_i + 1
          self.slug = self.slug.chars
          self.slug.pop
          self.slug = self.slug.join
          self.slug += "#{last}"
        end
      end
    end
  end

  def to_param
    self.slug
  end
end