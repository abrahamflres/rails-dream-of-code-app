class AddEnrollmentToSubmissions < ActiveRecord::Migration[8.0]
  def change
    add_reference :submissions, :enrollment, null: false, foreign_key: true
  end
end
