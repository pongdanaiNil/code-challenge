require 'rails_helper'

RSpec.describe Keyword, type: :model do
  describe 'Fields' do
    it { should have_db_column(:keyword).of_type(:text).with_options(null: false, default: "") }
  end

  describe 'Associations' do
    it { should have_one(:result) }
  end
end
