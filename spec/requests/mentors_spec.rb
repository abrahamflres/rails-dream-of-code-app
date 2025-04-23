require 'rails_helper'

RSpec.describe 'Mentors', type: :request do
  describe 'GET /mentors' do
    before do
      Mentor.create!(
        first_name: 'abraham',
        last_name: 'flores',
        email: 'abraham@test.com',
        max_concurrent_students: 5
      )
      Mentor.create!(
        first_name: 'john',
        last_name: 'doe',
        email: 'john@test.com',
        max_concurrent_students: 5
      )
    end

    it 'show all mentors with full names' do
      get mentors_path
      expect(response.body).to include('abraham')
      expect(response.body).to include('flores')
      expect(response.body).to include('john')
      expect(response.body).to include('doe')
    end
  end

  describe 'GET /mentors/:id' do
    let(:mentor) do
      Mentor.create!(
        first_name: 'abraham',
        last_name: 'flores',
        email: 'abraham@test.com',
        max_concurrent_students: 5
      )
    end

    it 'displays mentor details' do
      get mentor_path(mentor)
      expect(response.body).to include('abraham')
      expect(response.body).to include('flores')
      expect(response.body).to include('abraham@test.com')
    end
  end
end
