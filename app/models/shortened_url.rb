# require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base

  belongs_to :submitter,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  def self.random_code

    short_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(:short_url => short_url )
      short_url = SecureRandom.urlsafe_base64
    end

    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(user_id: user.id,
                         long_url: long_url,
                         short_url: self.random_code)
  end

end
