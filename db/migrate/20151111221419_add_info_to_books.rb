class AddInfoToBooks < ActiveRecord::Migration
  def change
    add_column  :books, :department, :string
    add_column  :books, :course, :string
    add_column  :books, :auction_start_price, :string
    add_column  :books, :auction_time, :datetime
    add_column  :books, :time_left, :string
  end
end
