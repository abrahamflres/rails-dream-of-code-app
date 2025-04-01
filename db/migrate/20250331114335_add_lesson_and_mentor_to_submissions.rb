class AddLessonAndMentorToSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :lesson_id, :integer
    add_column :submissions, :mentor_id, :integer
  end
end
