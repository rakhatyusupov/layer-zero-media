class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def up
    # email уже есть — только приводим к нужным ограничениям
    if column_exists?(:users, :email)
      change_column_default :users, :email, ""
      change_column_null    :users, :email, false
    else
      add_column :users, :email, :string, default: "", null: false
    end
    add_index :users, :email, unique: true unless index_exists?(:users, :email)

    # обязателен для Devise
    add_column :users, :encrypted_password, :string, default: "", null: false \
      unless column_exists?(:users, :encrypted_password)

    # опциональные модули (recoverable, rememberable, trackable, confirmable и т.д.)
    add_column :users, :reset_password_token,   :string unless column_exists?(:users, :reset_password_token)
    add_column :users, :reset_password_sent_at, :datetime unless column_exists?(:users, :reset_password_sent_at)
    add_index  :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)

    add_column :users, :remember_created_at, :datetime unless column_exists?(:users, :remember_created_at)
  end

  def down
    remove_index  :users, :email   if index_exists?(:users, :email)
    remove_index  :users, :reset_password_token if index_exists?(:users, :reset_password_token)
    remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)
    # email не трогаем — он существовал до Devise
  end
end
