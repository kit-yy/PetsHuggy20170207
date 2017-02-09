class AddColumToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :self_booking, :boolean
  end
end
