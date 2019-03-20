class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :location
      t.string :dates
      t.string :image_path
      t.string :price 
      t.string :user_id
    end
  end
end
