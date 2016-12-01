class Vote < ActiveRecord::Base

  validates_uniqueness_of :user_id, scope: :link_id
  validates_uniqueness_of :link_id, scope: :user_id

  belongs_to :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :link,
    class_name: "ShortenedUrl",
    primary_key: :id,
    foreign_key: :link_id

  
end
