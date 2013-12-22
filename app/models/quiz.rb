class Quiz < ActiveRecord::Base
  has_many :categories, dependent: :delete_all

  acts_as_list

  validates :name, presence: true
end
