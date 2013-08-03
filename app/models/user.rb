class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true
  validates :name, presence: true

  validates_uniqueness_of :uid, scope: :provider
  has_many :pitcher_favorites
  has_many :batter_favorites
  has_many :team_favorites

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.image_url = auth["info"]["image"]
      user.email = auth["info"]["email"]
      user.urls = auth["info"]["urls"]["Facebook"]
      user.location = auth["info"]["location"]
    end
  end
end
