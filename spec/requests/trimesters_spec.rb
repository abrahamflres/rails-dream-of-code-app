require 'rails_helper'

RSpec.describe 'Trimesters', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/trimesters/index'
      expect(response).to have_http_status(:success)
    end
  end
end

describe 'GET /trimesters' do
  context 'trimesters exist' do
    before do
      (1..2).each do |i|
        Trimester.create!(
          term: "Term #{i}",
          year: '2025',
          start_date: '2025-01-01',
          end_date: '2025-01-01',
          application_deadline: '2025-01-01' # removed space
        )
      end
    end

    it 'returns a page containing names of all trimesters' do
      get '/trimesters'
      expect(response.body).to include('Term 1 2025')
      expect(response.body).to include('Term 2 2025')
    end
  end
end

describe 'GET /trimesters' do
  context 'trimesters exist' do
    before do
      (1..2).each do |i|
        Trimester.create!(
          term: "Term #{i}",
          year: '2025',
          start_date: '2025-01-01',
          end_date: '2025-01-01',
          application_deadline: '2025-01-01'
        )
      end
    end

    it 'returns a page containing names of all trimesters' do
      get '/trimesters'
      expect(response.body).to include('Term 1 2025')
      expect(response.body).to include('Term 2 2025')
    end
  end

  context 'trimesters do not exist' do
    before do
    end

    it 'Show Trimesters title, no trimester list' do
      get '/trimesters'
      expect(response.body).to include('Trimesters')
      expect(response.body).not_to include('<li>')
    end
  end

  describe 'GET /trimesters/:id/edit' do
    it 'shows application deadline field' do
      trimester = Trimester.create!(
        term: 'Spring',
        year: '2025',
        start_date: '2025-01-01',
        end_date: '2025-04-01',
        application_deadline: '2024-12-01'
      )

      get edit_trimester_path(trimester)
      expect(response.body).to include('Application Deadline')
    end
  end
  describe 'PUT /trimesters/:id' do
    let!(:trimester) do
      Trimester.create!(
        term: 'Fall',
        year: '2025',
        start_date: '2025-09-01',
        end_date: '2025-12-01',
        application_deadline: '2025-08-01'
      )
    end

    it 'updates application deadline with valid date' do
      put trimester_path(trimester), params: {
        trimester: { application_deadline: '2025-07-15' }
      }

      expect(response).to redirect_to(trimesters_path)
      expect(trimester.reload.application_deadline).to eq(Date.parse('2025-07-15'))
    end

    it 'returns 400 if application deadline is blank' do
      put trimester_path(trimester), params: {
        trimester: { application_deadline: '' }
      }

      expect(response).to have_http_status(:bad_request)
    end

    it 'returns 400 if application deadline is invalid' do
      put trimester_path(trimester), params: {
        trimester: { application_deadline: 'invalid-date' }
      }

      expect(response).to have_http_status(:bad_request)
    end

    it 'returns 404 if trimester does not exist' do
      put '/trimesters/99999', params: {
        trimester: { application_deadline: '2025-07-15' }
      }

      expect(response).to have_http_status(:not_found)
    end
  end
end
