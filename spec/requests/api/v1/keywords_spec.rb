require 'rails_helper'

RSpec.describe "Api::V1::Keywords", type: :request do
  let!(:user)           { FactoryBot.create(:user) }
  let!(:application)    { FactoryBot.create(:application) }
  let!(:token)          { FactoryBot.create(:access_token, application:, resource_owner_id: user.id) }
  let!(:headers)        { { Authorization: "Bearer #{token.token}" } }

  describe "GET /index" do
    before { 0..5.times { FactoryBot.create(:keyword) } }

    it 'should get all keywords correctly' do
      get '/api/v1/keywords', headers: headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['count']).to eq(Keyword.count)
      expect(result['data'][0]['keyword']).to eq('Keyword 1')
      expect(result['data'][1]['keyword']).to eq('Keyword 2')
      expect(result['data'][2]['keyword']).to eq('Keyword 3')
      expect(result['data'][3]['keyword']).to eq('Keyword 4')
      expect(result['data'][4]['keyword']).to eq('Keyword 5')
    end

    it 'should get all keywords correctly with pagination' do
      get '/api/v1/keywords', headers: headers, params: { limit: 3, page: 0 }

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['count']).to eq(Keyword.count)
      expect(result['data'][0]['keyword']).to eq('Keyword 1')
      expect(result['data'][1]['keyword']).to eq('Keyword 2')
      expect(result['data'][2]['keyword']).to eq('Keyword 3')
    end

    it 'should render 401 when authorize header' do
      get '/api/v1/keywords'

      expect(response.status).to eq(401)
    end
  end

  describe "GET /show" do
    let!(:keyword)  { FactoryBot.create(:keyword) }

    it 'should get keyword correctly' do
      get "/api/v1/keywords/#{keyword.id}", headers: headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['data']['id']).to eq(keyword.id)
      expect(result['data']['keyword']).to eq(keyword.keyword)
    end

    it 'should render 404 when id not found' do
      get "/api/v1/keywords/9999", headers: headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(result['message']).to eq( I18n.t('not_found'))
    end

    it 'should render 401 when authorize header' do
      get "/api/v1/keywords/#{keyword.id}"

      expect(response.status).to eq(401)
    end
  end

  describe "POST /upload" do
    let!(:csv)      { Rack::Test::UploadedFile.new('public/test.csv', '.csv') }
    let!(:csv_101)  { Rack::Test::UploadedFile.new('public/test101.csv', '.csv') }

    it 'should upload csv file successfully' do
      post "/api/v1/keywords/upload", headers: headers, params: {
        csv_file: csv
      }

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['message']).to eq(I18n.t('keyword.success.uploaded'))
      expect(result['job_id'].present?).to eq(true)
    end

    it 'should render 400 when csv file contain more than 100 keywords ' do
      post "/api/v1/keywords/upload", headers: headers, params: {
        csv_file: csv_101
      }

      result = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(result['message']).to eq(I18n.t('keyword.error.exceed_length'))
    end
    
    it 'should render 400 when no csv file in params' do
      post "/api/v1/keywords/upload", headers: headers, params: {}

      result = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(result['message']).to eq(I18n.t('keyword.error.no_file'))
    end

    it 'should render 401 when authorize header' do
      post "/api/v1/keywords/upload", params: {
        csv_file: csv
      }

      expect(response.status).to eq(401)
    end
  end

  describe "PATCH /update" do
    let!(:update_keyword)  { FactoryBot.create(:keyword) }

    it 'should update keyword correctly' do
      patch "/api/v1/keywords/#{update_keyword.id}", headers: headers, params: {
        keyword: "New keyword"        
      }

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['message']).to eq( I18n.t('keyword.success.updated'))
      expect(result['data']['id']).to eq(update_keyword.id)
      expect(result['data']['keyword']).to eq("New keyword")
    end

    it 'should render 404 when id not found' do
      patch "/api/v1/keywords/9999", headers: headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(result['message']).to eq( I18n.t('not_found'))
    end

    it 'should render 401 when authorize header' do
      patch "/api/v1/keywords/#{update_keyword.id}"

      expect(response.status).to eq(401)
    end
  end

  describe "DELETE /destroy" do
    let!(:destroy_keyword)  { FactoryBot.create(:keyword) }

    it 'should destroy keyword correctly' do
      delete "/api/v1/keywords/#{destroy_keyword.id}", headers: headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['message']).to eq( I18n.t('keyword.success.destroyed'))
    end

    it 'should render 404 when id not found' do
      delete "/api/v1/keywords/9999", headers: headers

      result = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(result['message']).to eq( I18n.t('not_found'))
    end

    it 'should render 401 when authorize header' do
      delete "/api/v1/keywords/#{destroy_keyword.id}"

      expect(response.status).to eq(401)
    end
  end
end
