require 'faker'

FactoryBot.define do
  factory :user do
    email Faker::Internet.email

    pass = Faker::Internet.password
    password pass
    password_confirmation pass
  end
end
