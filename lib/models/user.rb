# frozen_string_literal: true

require 'sequel/model'

module Models
  class User < Sequel::Model
    model_schema do
      primary_key :id
      String :display_name, null: false
      String :mail_address, null: false
      String :encrypted_password, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP

      index :mail_address, name: :unique_mail_addresses, unique: true
      index :mail_address
    end
  end
end
