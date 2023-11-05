class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :day
      t.string :time
      t.string :user_id
      t.string :car_id
      t.date :start_time
      t.date :end_time
      t.timestamps
    end
  end
end
