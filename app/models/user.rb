class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, unique: true
  validates :password, length: { minimum: 6 }
end
