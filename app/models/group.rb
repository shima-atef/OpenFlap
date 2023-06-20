class Group < ApplicationRecord
  has_many  :tasks
  has_many  :members
  belongs_to :user
  has_many :users, through: :members
  has_many :exercises, through: :tasks
end
