class Lesson < ApplicationRecord
  belongs_to :course
  has_many :related_topic_lessons
  has_many :topics, through: :related_topic_lessons
end
