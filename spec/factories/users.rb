FactoryBot.define do
  factory :user do
    sequence(:name)                   { |n| "user#{n}" }
    sequence(:email)                  { |n| "test#{n}@example.com" }
    password                          { SecureRandom.base64 64 }
    password_confirmation             { password }
  end
end
