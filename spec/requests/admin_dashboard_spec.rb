require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      @current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      @past_trimester = Trimester.create!(
        term: 'Old term',
        year: (Date.today.year - 1).to_s,
        start_date: Date.today - 1.year,
        end_date: Date.today - 11.months,
        application_deadline: Date.today - 1.year - 1.week
      )
      @upcoming_trimester = Trimester.create!(
        term: 'Upcoming term',
        year: (Date.today + 1.month).year.to_s,
        start_date: Date.today + 1.month,
        end_date: Date.today + 4.months,
        application_deadline: Date.today + 2.weeks
      )
    end

    it 'returns a 200 OK status' do
      get '/dashboard'
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get '/dashboard'
      expect(response.body).to include("#{@current_trimester.term} #{@current_trimester.year} Courses")
    end

    it 'does not display the past trimester' do
      get '/dashboard'
      expect(response.body).not_to include("Old term - #{Date.today.year - 1}")
    end

    # Leave these empty for now
    it 'displays links to the courses in the current trimester' do
    end

    it 'displays the upcoming trimester' do
      get '/dashboard'
      expect(response.body).to include("#{@upcoming_trimester.term} #{@upcoming_trimester.year} Courses")
    end

    it 'displays links to the courses in the upcoming trimester' do
    end
  end
end
RSpec.describe 'Admin Dashboard', type: :request do
  describe 'GET /course/:id/students' do
    before do
      @trimester = Trimester.create!(
        term: 'Summer',
        year: '2025',
        start_date: Date.today,
        end_date: Date.today + 3.months,
        application_deadline: Date.today + 1.month
      )

      @course = Course.create!(
        coding_class: CodingClass.create!(title: 'Ruby on Rails'),
        trimester: @trimester,
        max_enrollment: 30
      )

      @student = Student.create!(
        first_name: 'Abraham',
        last_name: 'Flores',
        email: 'abrahamflores@test.com'
      )

      Enrollment.create!(course: @course, student: @student)

      it 'displays the course name' do
        get course_students_path(@course.id)
        expect(response.body).to include('Ruby on Rails')
      end

      it 'displays at least one student name' do
        get course_students_path(@course.id)
        expect(response.body).to include('Abraham Flores')
      end
    end
  end
end
