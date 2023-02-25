require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Fields' do
    it { should have_db_column(:name).of_type(:string).with_options(null: false, default: "") }
    it { should have_db_column(:email).of_type(:string).with_options(null: false, default: "") }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: "") }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
