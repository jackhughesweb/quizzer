class Question < ActiveRecord::Base
  belongs_to :category

  acts_as_list

  validates :question, presence: true
  validates :correct_answer, presence: true
  validates :altone_answer, presence: true
  validates :alttwo_answer, presence: true
  validates :altthree_answer, presence: true
end
