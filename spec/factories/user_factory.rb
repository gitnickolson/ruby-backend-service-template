# frozen_string_literal: true

FactoryBot.define do
  to_create(&:save)

  factory(:user, class: 'Models::User') do
    username { 'foo' }
    mail_address { 'foo@bar.com' }
    password_hash { 'hashed_password' }
    verified { true }
    created_at { Time.new(2023, 5, 20, 12, 2, 2) }
  end
end
