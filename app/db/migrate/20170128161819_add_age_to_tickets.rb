class AddAgeToTickets < ActiveRecord::Migration[5.0]
  def change
      add_column :tickets, :age, :integer
  end
end
