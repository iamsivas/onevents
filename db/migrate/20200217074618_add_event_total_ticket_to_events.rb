class AddEventTotalTicketToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_total_ticket, :integer
  end
end
