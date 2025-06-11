class Api::V1::EnrollmentsController < ApplicationController
  def index
    course = Course.find(params[:course_id])

    enrollments_data = course.enrollments.includes(:student).map do |enrollment|
      {
        id: enrollment.student.id,
        enrollment_id: enrollment.id,
        course_id: course.id,
        course_title: course.coding_class.title,
        student_name: "#{enrollment.student.first_name} #{enrollment.student.last_name}",
        final_grade: enrollment.final_grade
      }
    end

    render json: { enrollments: enrollments_data }, status: :ok
  end
end
