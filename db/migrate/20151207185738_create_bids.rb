class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.belongs_to :user, index:true
      t.belongs_to :book, index:true
      t.string :bid
      t.boolean :notification, default: false
    end
  end
end
