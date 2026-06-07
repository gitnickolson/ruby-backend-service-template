# frozen_string_literal: true

require 'sequel/model'

module Models
  class User < Sequel::Model(:users)
    model_schema do
      primary_key :id
      String :username, null: false
      String :mail_address, null: false
      String :password_hash, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP

      index :username, name: :unique_usernames, unique: true
      index :mail_address, name: :unique_mail_addresses, unique: true
    end
  end
end
