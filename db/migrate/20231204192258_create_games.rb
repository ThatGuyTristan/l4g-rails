class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.string :release_date
      t.string :esrb_rating
      t.string :developer
      t.string :publisher
      t.string :genre
      t.integer :min_players
      t.integer :max_players
      t.references :system, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
