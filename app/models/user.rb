class User < ActiveRecord::Base
  has_many :posts
  has_many :clubs

  has_secure_password
end
