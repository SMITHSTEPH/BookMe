class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
       t.belongs_to :book, index:true
       t.string :tag
    end
  end
end
