class Club < ActiveRecord::Base
  has_many :posts
  has_many :users, through: :user_clubs

  def slug
    self.name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|club| club.slug == slug}
  end

end
