# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username, null: false
      String :mail_address, null: false
      String :password_hash, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    alter_table(:users) do
      add_index :mail_address, name: :unique_mail_addresses, unique: true
    end
  end
end
