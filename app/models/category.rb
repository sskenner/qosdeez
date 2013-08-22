class Category < ActiveRecord::Base
  belongs_to :post
  has_many :labels
  has_many :posts, through: :labels

  validates :name, presence: true
end