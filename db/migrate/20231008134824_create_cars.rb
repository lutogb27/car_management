class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :user_id
      t.string :introduction
      t.string :car_name
      t.timestamps
    end
  end
end
