class Post < ActiveRecord::Base
  has_many :posted_tags
  has_many :tags, through: :posted_tags
  has_many :comments

  belongs_to :user 
  belongs_to :center
end
