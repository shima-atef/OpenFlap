class Submission < ApplicationRecord
    belongs_to :user
    belongs_to :exercise
   
    validates :user_id, presence: true
    validates :exercise_id, presence: true
    validates :solution, presence: true
    validate :solution_uniqueness_for_user
  
    private
  
    def solution_uniqueness_for_user
      if user.submissions.exists?(solution: solution)
        errors.add(:solution, 'has already been submitted')
      end
    end
end
