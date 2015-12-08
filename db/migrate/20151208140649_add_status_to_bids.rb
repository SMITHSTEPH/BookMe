class AddStatusToBids < ActiveRecord::Migration
  def change
    add_column  :bids, :status, :string, default: "highest bid"
  end
end
