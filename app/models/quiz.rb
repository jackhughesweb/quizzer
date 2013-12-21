class Quiz < ActiveRecord::Base
  has_many :categories, dependent: :delete_all
end
