class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :question_id
      t.string :answer

      t.timestamps
    end
  end
end
