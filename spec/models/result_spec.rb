require 'rails_helper'

RSpec.describe Result, type: :model do
  describe 'Fields' do
    it { should have_db_column(:adwords_advertisers_count).of_type(:integer).with_options(null: false, default: 0) }
    it { should have_db_column(:links_count).of_type(:integer).with_options(null: false, default: 0) }
    it { should have_db_column(:total_search_results).of_type(:string).with_options(null: false, default: '0') }
    it { should have_db_column(:html_code).of_type(:text).with_options(null: false, default: '') }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'Associations' do
    it { should belong_to(:keyword) }
  end
end
