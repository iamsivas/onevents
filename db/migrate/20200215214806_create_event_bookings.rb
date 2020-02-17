class CreateEventBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :event_bookings do |t|
      t.integer :event_id
      t.integer :user_id
      t.float :total_price
      t.integer :total_ticket
    end
  end
end
