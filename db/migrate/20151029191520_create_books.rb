class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.string :quality
      t.string :image
      t.string :price
      t.text :description
      t.string :seller
    end
  end
end
