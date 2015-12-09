# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [{first_name:"Sarah", last_name:"Gerard", email:"sarah-gerard@uiowa.edu", user_id:"segerard", password:"selt10", password_confirmation:"selt10", books_bought:0, books_sold:0},
         {first_name:"Stephanie", last_name:"Smith", email:"stephanie-smith@uiowa.edu", user_id:"ssmith", password:"selt20", password_confirmation:"selt20", books_bought:0, books_sold:0},
         {first_name:"Blake", last_name:"Dunham", email:"blake-dunham@uiowa.edu", user_id:"bdunham", password:"selt30", password_confirmation:"selt30", books_bought:0, books_sold:0},
         {first_name:"Ramya", last_name:"Puliadi", email:"ramya-puliadi@uiowa.edu", user_id:"rpuliadi", password:"selt40", password_confirmation:"selt40", books_bought:0, books_sold:0},
]
 
users.each do |user|
  User.create!(user)
end

books = [{:title => 'Algorithm Design', :author => 'Kleinberg Tardos', :isbn => '9788131703106', :quality => 'great', :price => '50.00', :image => 'algorithm.jpg', :bid_price=>'20.00',:auction_start_price=>'20.00', :auction_time=> DateTime.strptime("01/01/2016 8:00", "%m/%d/%Y %H:%M")},
          {:title => 'Medical Imaging', :author => 'Sonka Fitzpatrick', :isbn => '0819436224', :quality => 'fair', :price => '60.00', :image => 'medicalimaging.jpg', :bid_price=>'25.00',:auction_start_price=>'25.00', :auction_time=> DateTime.strptime("01/01/2016 8:00", "%m/%d/%Y %H:%M")},
          {:title => 'Image Processing, Analysis, and Machine Vision', :author => 'Sonka Hlavac Boyle', :isbn => '0534953930', :quality => 'great', :price => '55.00', :image => 'imageprocessing.jpg', :bid_price=>'15.00', :auction_start_price =>'15.00', :auction_time=> DateTime.strptime("01/01/2016 8:00", "%m/%d/%Y %H:%M")},
          {:title => 'A Guide to Latex', :author => 'Kopka Daly', :isbn => '0201568896', :quality => 'great', :price => '40.00',:image => 'latex.jpg', :bid_price=>'10.00', :auction_start_price=>'10.00', :auction_time=> DateTime.strptime("01/01/2016 8:00", "%m/%d/%Y %H:%M")},

]

user1 = User.find_by_user_id("segerard")
user2 = User.find_by_user_id("ssmith")
user3 = User.find_by_user_id("bdunham")
user4 = User.find_by_user_id("rpuliadi")

user1.books.create!(books[0])
user2.books.create!(books[1])
user3.books.create!(books[2])
user4.books.create!(books[3])

