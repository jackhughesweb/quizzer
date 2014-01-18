class Answer < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :player
  belongs_to :game
end
