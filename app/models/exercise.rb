class Exercise < ApplicationRecord
    has_many  :tasks
    has_many  :submissions
    belongs_to :user
    has_many :groups, through: :tasks
end
