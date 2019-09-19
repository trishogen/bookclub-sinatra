class Club < ActiveRecord::Base
  has_many :posts
  has_many :users, through: :user_clubs
end
