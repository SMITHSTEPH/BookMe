# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

books = [{:title => 'Algorithm Design', :author => 'Kleinberg Tardos', :isbn => '9788131703106', :quality => 'great', :price => '50.00', :image => 'nobook.gif'},
          {:title => 'Medical Imaging', :author => 'Sonka Fitzpatrick', :isbn => '0819436224', :quality => 'fair', :price => '60.00', :image => 'nobook.gif'},
          {:title => 'Image Processing, Analysis, and Machine Vision', :author => 'Sonka Hlavac Boyle', :isbn => '0534953930', :quality => 'great', :price => '55.00', :image => 'nobook.gif'},
          {:title => 'A Guide to Latex', :author => 'Kopka Daly', :isbn => '0201568896', :quality => 'great', :price => '40.00',:image => 'nobook.gif'},
]



books.each do |book|
  Book.create!(book)
end
