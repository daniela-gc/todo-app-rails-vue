require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  # initialize test data
  let!(:task_items) { create_list(:task_item, 7) }
  let(:task_item_id) { task_items.first.id }

  # Test suite for GET /task_items
  describe 'GET /task_items' do
    # make HTTP get request before each example
    before { get '/api/v1/task_items' }

    it 'returns task items' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json).to be_kind_of(Hash)
      expect(json['data'].size).to eq(7)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /task_items/:id
  describe 'GET /task_items/:id' do
    before { get "/api/v1/task_items/#{task_item_id}" }

    context 'when the record exists' do
      it 'returns the task item' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq("#{task_item_id}")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      it 'raises Record Not Found error' do
        expect {
          get '/api/v1/task_items/0'
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  # Test suite for POST /task_items
  describe 'POST /task_items' do
    # valid payload
    let(:valid_attributes) { { task_item: { description: 'Make dinner' } } }

    context 'when the request is valid' do
      before { post '/api/v1/task_items', params: valid_attributes }

      it 'creates a task item' do
        expect(json['data']['attributes']['description']).to match('Make dinner')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/task_items', params: { task_item: { description: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /task_items/:id
  describe 'PUT /task_items/:id' do
    let(:valid_attributes) { { task_item: { description: 'Make breakfast' } } }

    before { put "/api/v1/task_items/#{task_item_id}", params: valid_attributes }

    context 'when the record exists' do
      it 'updates the record' do
        updated_task = TaskItem.find(task_item_id)
        expect(updated_task.description).to match(/Make breakfast/)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      it 'raises Record Not Found error' do
        expect {
          put '/api/v1/task_items/0'
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  # Test suite for DELETE /task_items/:id
  describe 'DELETE /task_items/:id' do
    before { delete "/api/v1/task_items/#{task_item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
