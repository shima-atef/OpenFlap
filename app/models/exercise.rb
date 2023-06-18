class Exercise < ApplicationRecord
   
    has_many  :tasks
    has_many  :submissions
    belongs_to :user
    has_many :groups, through: :tasks
    validates :title, presence: true
 
    validate :title_exercise_type_uniqueness
    
    private
    
    def title_exercise_type_uniqueness
      if Exercise.exists?(title: title, exercise_type: exercise_type)
        errors.add(:base, 'Exercise already exists')
      end
    end
   
end
