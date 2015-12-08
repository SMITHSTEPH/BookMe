class AddNotificationToBooks < ActiveRecord::Migration
  def change
    add_column  :books, :notification, :boolean, default: false
  end
end
