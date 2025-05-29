class AdminDashboardController < ApplicationController
  before_action :require_admin

  def index
    @current_trimester = Trimester.where('start_date <= ?', Date.today)
                                  .where('end_date >= ?', Date.today)
                                  .first
    @upcoming_trimester = Trimester.where('start_date > ? AND start_date <= ?', Date.today, Date.today + 6.months)
                                   .order(:start_date)
                                   .first

    @upcoming_courses = @upcoming_trimester&.courses || []
  end

  def course_students
    @course = Course.find(params[:id])
    @students = @course.enrollments.includes(:student).map(&:student)
  end
end
