class Tag < ActiveRecord::Base
  has_many :posted_tags
  has_many :posts, through: :posted_tags
end
