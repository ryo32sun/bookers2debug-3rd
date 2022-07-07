class Favorite < ApplicationRecord
  
  belongs_to :book
  belongs_to :user
  
  
  # scope :week_count, -> { where(created_at: Time.current.at_end_of_day..(to - 6.day).at_beginning_of_day) }
  
end
