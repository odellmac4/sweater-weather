require 'rails_helper'

RSpec.describe 'User registration' do
  describe 'endpoint 2' do

    it 'registers a user', :vcr do
      user_params = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      post '/api/v0/users', params: user_params.to_json, headers: { 'Content-Type' => 'application/json' }
      
      expect(response).to have_http_status(:created)

      created_user_response = JSON.parse(response.body, symbolize_names: true)

      expect(created_user_response[:data]).to be_a Hash
      expect(created_user_response[:data]).to have_key (:type)
      expect(created_user_response[:data]).to have_key (:id)
      expect(created_user_response[:data]).to have_key (:attributes)
      expect(created_user_response[:data][:attributes]).to have_key (:email)
      expect(created_user_response[:data][:attributes][:email]).to eq("whatever@example.com")
      expect(created_user_response[:data][:attributes]).to have_key (:api_key)

    end

    it 'return error message when user info is invalid' do
      user_params = {
        "email": "creamontheinside@paintjob.com",
        "password": "icecream",
        "password_confirmation": "icecream23"
      }

      post '/api/v0/users', params: user_params.to_json, headers: { 'Content-Type' => 'application/json' }
      
      expect(response).to have_http_status(400)
      
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to be_a Hash
      expect(error_response[:errors].first[:detail]).to eq ("Validation failed: Password confirmation doesn't match Password")
    end
  end
end