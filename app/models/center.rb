class Center < ActiveRecord::Base
  has_many :images
  has_many :center_programs
  has_many :programs, through: :center_programs

  has_many :posts
end
