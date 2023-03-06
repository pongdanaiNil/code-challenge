require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user)           { FactoryBot.create(:user) }
  let!(:application)    { FactoryBot.create(:application) }
  let!(:token)          { FactoryBot.create(:access_token, application:, resource_owner_id: user.id) }
  let!(:headers)        { { Authorization: "Bearer #{token.token}" } }

  describe "Post /registration" do
    it 'should create new user correctly' do

      registration_data = {
        name: "Captain",
        email: "pongdanai.ni@gmail.com",
        password: "MNT436MY",
        password_confirmation: "MNT436MY"
      }

      post '/api/v1/users/registration', params: registration_data

      result = JSON.parse(response.body)
      expect(response.status).to eq(201)
      expect(result['user']['name']).to eq(registration_data[:name])
      expect(result['user']['email']).to eq(registration_data[:email])
      expect(User.count).to eq(2)
    end

    it 'should not create new user if email bank' do

      registration_data = {
        name: "Captain",
        email: "",
        password: "MNT436MY",
        password_confirmation: "MNT436MY"
      }

      post '/api/v1/users/registration', params: registration_data

      result = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(result['message']).to eq("Email can't be blank")
    end

    it 'should not create new user if email taken' do
      FactoryBot.create(:user, email: 'pongdanai.ni@gmail.com')

      registration_data = {
        name: "Captain",
        email: "pongdanai.ni@gmail.com",
        password: "MNT436MY",
        password_confirmation: "MNT436MY"
      }

      post '/api/v1/users/registration', params: registration_data

      result = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(result['message']).to eq("Email has already been taken")
    end

    it 'should not create new user if password bank' do

      registration_data = {
        name: "Captain",
        email: "pongdanai.ni@gmail.com",
        password: "",
        password_confirmation: ""
      }

      post '/api/v1/users/registration', params: registration_data

      result = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(result['message']).to eq("Password can't be blank")
    end
  end
end
