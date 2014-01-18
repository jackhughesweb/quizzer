class AddCurrentquestionToGames < ActiveRecord::Migration
  def change
    add_column :games, :currentquestion, :integer
  end
end
