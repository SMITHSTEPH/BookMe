class AddBooksSoldToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :books_sold, :integer
    add_column  :users, :books_bought, :integer
  end
end
