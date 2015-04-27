class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  def capitalized_title
   title.capitalize
  end
end
