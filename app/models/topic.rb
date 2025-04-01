class Topic < ApplicationRecord
  has_many :related_topic_lessons
  has_many :lessons, through: :related_topic_lessons
end
