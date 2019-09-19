class User < ActiveRecord::Base
  has_many :posts
  has_many :clubs, through: :user_clubs
end
