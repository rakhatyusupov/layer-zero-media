class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  enum :role, { user: 0, editor: 1, admin: 2 }, prefix: true
end

