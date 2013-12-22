class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.string :correct_answer
      t.string :altone_answer
      t.string :alttwo_answer
      t.string :altthree_answer
      t.integer :category_id

      t.timestamps
    end
  end
end
