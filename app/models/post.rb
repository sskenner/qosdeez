class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User',
                       foreign_key: 'user_id'
  has_many :comments
  has_many :labels
  has_many :categories, through: :labels
  has_many :votes, as: :voteable

  validates :title, presence: true

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
end