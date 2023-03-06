require 'rails_helper'

RSpec.describe DataScraping, type: :service do
  include ActiveJob::TestHelper

  describe '#call' do
    it 'should create result record with scraped data for keyword record' do
      Keyword.skip_callback(:save, :after, :search)
      keyword = Keyword.create(keyword: 'Create without save callback')

      expect(keyword.result).to eq(nil)

      DataScraping.call(keyword.id, keyword.keyword)
      keyword.reload

      expect(keyword.result.present?).to eq(true)
      Keyword.set_callback(:save, :after, :search)
    end
  end
end
