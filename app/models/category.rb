class Category < ActiveRecord::Base
  belongs_to :quiz
  has_many :questions, dependent: :delete_all

  validates :name, presence: true
end
