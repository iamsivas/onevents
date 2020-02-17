class AddUserIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :user_id, :integer
    add_column :events, :ticket_left, :integer
    add_column :events, :status, :string
  end
end
