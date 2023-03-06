require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SearchKeywordJob, type: :job do
  include ActiveJob::TestHelper

  describe 'perform' do
    let!(:keyword)        { FactoryBot.create(:keyword) }
    subject(:job)         { SearchKeywordJob.perform_async(keyword.id, keyword.keyword) }

    it 'queues the job' do
      expect do
        SearchKeywordJob.perform_async(keyword.id, keyword.keyword)
      end.to change(SearchKeywordJob.jobs, :size).by(1)
    end

  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
