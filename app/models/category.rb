class Category < ActiveRecord::Base
  belongs_to :quiz
  has_many :questions, dependent: :delete_all

  acts_as_list

  validates :name, presence: true
end
