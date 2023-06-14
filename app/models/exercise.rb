class Exercise < ApplicationRecord
    has_many  :tasks
    has_many  :submissions
    belongs_to :user
end
