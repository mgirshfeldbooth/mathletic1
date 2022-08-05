class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :question
      t.float :answer
      t.integer :difficulty

      t.timestamps
    end
  end
end
