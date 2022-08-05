class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.boolean :correct
      t.datetime :started_at
      t.datetime :finished_at
      t.float :submission
      t.integer :user_id
      t.integer :exercise_id
      t.integer :round_id

      t.timestamps
    end
  end
end
