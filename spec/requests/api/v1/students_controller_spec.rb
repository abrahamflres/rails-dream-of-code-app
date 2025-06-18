require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request do
  describe 'POST /api/v1/students' do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    it 'creates a new student' do
      expect do
        post '/api/v1/students', params: valid_attributes
      end.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq('validstudent@example.com')
    end
  end
end

RSpec.describe 'Api::V1::Students', type: :request do
  describe 'POST /api/v1/students' do
    context 'with invalid parameters' do
      it 'Invalid creation of student record' do
        invalid_params = {
          student: {
            first_name: 'Invalid',
            last_name: 'User'
          }
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/students', params: invalid_params.to_json, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json['errors']).to include('Email must be present')
      end
    end
  end
end
