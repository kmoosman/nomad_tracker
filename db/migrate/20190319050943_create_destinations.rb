class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :start_date
      t.string :end_date
      t.string :image_name
      t.string :price 
      t.string :user_id
    end
  end
end
