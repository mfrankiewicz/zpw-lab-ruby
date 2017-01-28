class AddSeatCountToEvents < ActiveRecord::Migration[5.0]
  def change
      add_column :events, :seat_count, :integer
  end
end
