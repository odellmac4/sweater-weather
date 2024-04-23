require 'rails_helper'

RSpec.describe 'Sessions' do
  describe 'endpoint 3' do
    before(:each) do
      user_params = {
        "email": "alain@dream.com",
        "password": "drety23",
        "password_confirmation": "drety23"
      }

      post '/api/v0/users', params: user_params.to_json, headers: { 'Content-Type' => 'application/json' }
    end
    it 'returns email and password of a user' do
      session_params = {
        "email": "alain@dream.com",
        "password": "drety23"
      }

      post '/api/v0/sessions', params: session_params.to_json, headers: { 'Content-Type' => 'application/json' }

      expect(response).to have_http_status(:created)

      created_session_response = JSON.parse(response.body, symbolize_names: true)

      expect(created_session_response[:data]).to be_a Hash
      expect(created_session_response[:data]).to have_key (:type)
      expect(created_session_response[:data]).to have_key (:id)
      expect(created_session_response[:data]).to have_key (:attributes)
      expect(created_session_response[:data][:attributes]).to have_key (:email)
      expect(created_session_response[:data][:attributes][:email]).to eq("alain@dream.com")
      expect(created_session_response[:data][:attributes]).to have_key (:api_key)
    end

    it 'returns error when invalid password' do
      session_params = {
        "email": "alain@dream.com",
        "password": "drety2345"
      }

      post '/api/v0/sessions', params: session_params.to_json, headers: { 'Content-Type' => 'application/json' }

      expect(response).to have_http_status(404)
      
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to be_a Hash
      expect(error_response[:errors].first[:detail]).to eq ("Couldn't find User with email: alain@dream.com and password: drety2345")
    end

    it 'returns error when invalid email' do
      session_params = {
        "email": "alai@dream.com",
        "password": "drety23"
      }

      post '/api/v0/sessions', params: session_params.to_json, headers: { 'Content-Type' => 'application/json' }

      expect(response).to have_http_status(404)
      
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to be_a Hash
      expect(error_response[:errors].first[:detail]).to eq ("Couldn't find User with email: alai@dream.com and password: drety23")
    end
  end
end