class Category < ActiveRecord::Base


  belongs_to :post
  has_many :labels
  has_many :posts, through: :labels

  validates :name, presence: true, uniqueness: true

  after_validation :generate_slug

  def generate_slug
    self.slug = self.name.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end