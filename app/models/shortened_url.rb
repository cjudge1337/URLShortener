# require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base
  validate :valid_length?
  validate :valid_number_urls?

  belongs_to :submitter,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: "Visit",
    primary_key: :id,
    foreign_key: :shortened_id

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    class_name: "Tagging",
    primary_key: :id,
    foreign_key: :link_id

  has_many :tags,
    through: :taggings,
    source: :tag

  def self.prune
    self.where("created_at < ?", 20.minutes.ago).delete_all
  end

  def self.random_code(user)
    if user.premium
      short_url = self.premium_random_code
    else
      short_url = self.random_code
    end

    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(user_id: user.id,
                         long_url: long_url,
                         short_url: self.random_code)
  end

  def self.premium_random_code
    words = File.readlines('/Users/appacademy/Desktop/W3D3/URLShortener/lib/assets/dictionary.txt').map(&:chomp)
    words.sample(2).join("")
  end

  def self.standard_random_code
    short_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(:short_url => short_url )
      short_url = SecureRandom.urlsafe_base64
    end

    short_url
  end

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors
  end

  def num_recent_uniques
    self.visits.where(created_at: (10.minutes.ago..Time.now)).select(:user_id).distinct.count
  end

  def users_recent_links(id)
    user = User.find_by_id(id)
    user.submitted_urls.where(created_at: (1.minute.ago..Time.now)).count
  end

  def is_premium_user?(id)
    User.find_by_id(id).premium
  end

  private

  def valid_length?
    if long_url.length >= 1024
      errors[:long_url] << "cannot be that long"
    end
  end

  def valid_number_urls?
    return true if is_premium_user?(user_id)
    url_count = users_recent_links(user_id)

    if url_count > 5
      errors[:base] << "too many urls from this user"
    end
  end
end
