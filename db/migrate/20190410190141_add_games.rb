class AddGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :publisher
      t.string :genre # Should be it's own table but for this project imma take the easy way out.
      t.string :description
      t.string :image_icon # If I decide that I want to add icons.

      t.timestamps
    end
  end
end
