class Api::V1::CoursesController < ApplicationController
  def index
    courses = Course
              .joins(:trimester)
              .where('trimesters.start_date <= ? AND trimesters.end_date >= ?', Date.today, Date.today)

    courses_format = courses.map do |course|
      {
        id: course.id,
        title: course.coding_class&.title,
        application_deadline: course.trimester&.application_deadline,
        start_date: course.trimester&.start_date,
        end_date: course.trimester&.end_date
      }
    end

    render json: { courses: courses_format }, status: :ok
  end
end
