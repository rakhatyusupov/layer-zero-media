class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum :role, { user: 0, editor: 1, admin: 2 }

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
end

