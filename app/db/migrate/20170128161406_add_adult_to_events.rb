class AddAdultToEvents < ActiveRecord::Migration[5.0]
  def change
      add_column :events, :adult, :boolean
  end
end
