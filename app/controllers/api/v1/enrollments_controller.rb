class Api::V1::EnrollmentsController < ApplicationController
  def index
    current_trimester = Trimester.current
    courses = Course.where(trimester: current_trimester)

    enrollments_data = []

    courses.each do |course|
      course.enrollments.includes(:student).each do |enrollment|
        enrollments_data << {
          enrollment_id: enrollment.id,
          course_id: course.id,
          course_title: course.coding_class.title,
          student_name: "#{enrollment.student.first_name} #{enrollment.student.last_name}",
          final_grade: enrollment.final_grade
        }
      end
    end

    render json: { enrollments: enrollments_data }, status: :ok
  end
end
