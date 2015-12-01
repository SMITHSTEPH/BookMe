class AddBidToBooks < ActiveRecord::Migration
  def change
    add_column  :books, :bid_price, :string
    add_column  :books, :bidder_id, :string
    add_column  :books, :status, :string
  end
end
