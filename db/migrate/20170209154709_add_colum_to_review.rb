class AddColumToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :listing, index: true, foreign_key: true
  end
end
