class Tagging < ActiveRecord::Base

  belongs_to :tag,
    class_name: "TagTopic",
    primary_key: :id,
    foreign_key: :topic_id

  belongs_to :link,
    class_name: "ShortenedUrl",
    primary_key: :id,
    foreign_key: :link_id
end
