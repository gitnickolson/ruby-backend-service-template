# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :display_name, null: false
      String :encrypted_email, null: false
      String :encrypted_password, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    alter_table(:users) do
      add_index :encrypted_email
      add_unique_constraint :encrypted_email, name: :unique_emails
    end
  end
end
