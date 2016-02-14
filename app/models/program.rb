class Program < ActiveRecord::Base
  has_many :center_programs
  has_many :centers, through: :center_programs
end
