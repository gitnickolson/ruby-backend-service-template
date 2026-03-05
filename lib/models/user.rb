# frozen_string_literal: true

require 'sequel/model'

module Models
  class User < Sequel::Model
    model_schema do
      primary_key :id
      String :display_name, null: false
      String :encrypted_email, null: false
      String :encrypted_password, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP

      index :encrypted_email, name: :unique_emails, unique: true
      index :encrypted_email
    end
  end
end
