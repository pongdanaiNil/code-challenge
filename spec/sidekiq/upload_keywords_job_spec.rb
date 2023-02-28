require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe UploadKeywordsJob, type: :job do
  include ActiveJob::TestHelper

  describe 'perform' do
    let!(:keywords)       { ["keyword test 1", "keyword test 2", "keyword test 3", "keyword test 4"] }
    subject(:job)         { UploadKeywordsJob.perform_async(keywords) }

    it 'queues the job' do
      expect do
        UploadKeywordsJob.perform_async(keywords)
      end.to change(UploadKeywordsJob.jobs, :size).by(1)
    end

  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
