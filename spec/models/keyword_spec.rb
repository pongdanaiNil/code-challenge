require 'rails_helper'

RSpec.describe Keyword, type: :model do
  describe 'Fields' do
    it { should have_db_column(:keyword).of_type(:text).with_options(null: false, default: "") }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'Associations' do
    it { should have_one(:result) }
  end
end
