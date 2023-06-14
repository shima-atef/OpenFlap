class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def first_name
          read_attribute(:first_name)
        end
      
        def first_name=(value)
          write_attribute(:first_name, value)
        end
      
        def last_name
          read_attribute(:last_name)
        end
      
        def last_name=(value)
          write_attribute(:last_name, value)
        end
end
