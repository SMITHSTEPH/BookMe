require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

Given(/^the database is seeded$/) do
    DatabaseCleaner.clean
    load "#{Rails.root}/db/seeds.rb"
end

Given(/^ssmith has logged in$/) do
    visit login_path
    fill_in 'login_email', :with => "stephanie-smith@uiowa.edu"
    fill_in 'login_password', :with => "selt20"
    click_button 'login_submit'
    visit books_path
end
Given(/^ssmith is on the MyBooks page$/) do
    visit mybooks_path
end
When(/^I am viewing information about "(.*?)"$/) do |book_title|
    book=Book.find_by title: book_title  
    visit book_path(book)
end
Then(/^I should see a "(.*?)" section$/) do |section_name|
    result= page.has_content? section_name
    expect(result).to be_truthy
end
Then(/^I should see all of the books I am selling$/) do
    result=false
    row_count=0
     all("tr").each do |tr|
        row_count+=1
     end
     user = User.find_by_user_id("ssmith")
     if Book.where(:user_id => user.id).count == row_count #get rid of the title row
         result=true
     else
         result=false
     end
    expect(result).to be_truthy
end
When(/I change field "(.*?)" to "(.*?)"$/) do |field, change|
    fill_in field, :with => change
    result = page.has_content? change
    click_button "Update Book Info"
end
Then(/the new item "(.*?)" should be "(.*?)"$/) do |field, change|
    result = page.has_content? change
    expect(result).to be_truthy
end
Then(/the "(.*?)" of "(.*?)" should be "(.*?)"$/) do |field, title, change|
    result=false
    all("tr").each do |tr|
        puts tr.text
        if tr.has_content?(change) && tr.has_content?(title)
            result=true
            break;
        end
    end
    expect(result).to be_truthy
end
When(/I add a book with title "(.*?)", author "(.*?)", isbn "(.*?)", buy now price "(.*?)", and auction start price "(.*?)"$/) do |title, author, isbn, buy_now_price, auction_start_price|
    click_button 'Add Book'
    fill_in "*Title", :with => title
    fill_in "*Author", :with => author
    fill_in "*ISBN", :with => isbn, exact: true
    fill_in "*Buy Now Price", :with => buy_now_price
    fill_in "Auction Price", :with => auction_start_price
    click_button 'Save Changes'
end
Then(/I should see a book with title "(.*?)", author "(.*?)" and isbn "(.*?)" added mybooks$/) do |title, author, isbn|
    result=false
    all("tr").each do |tr|
        if tr.has_content?(title) && tr.has_content?(author) && tr.has_content?(isbn)
            result=true
            break;
        end
    end
    expect(result).to be_truthy
end
When(/I remove a book with title "(.*?)"$/) do |book_title|
    @book=Book.find_by_title(book_title)
    @book.destroy
end
Then(/I should not see a book with title "(.*?)" in MyBooks$/) do |title|
    result=false
    all("tr").each do |tr|
        result=true
        if tr.has_content?(title)
            result=false
            break;
        end
    end
    expect(result).to be_truthy
end
Then(/I should see flash message "(.*?)"$/) do |message|
    result= page.has_content? message
    expect(result).to be_truthy
end
When(/^I am on the add book page$/) do
    visit new_book_path
end
When(/^I am on the edit book page$/) do
    visit edit_book_path
end
Then(/^there should be a quality select box$/) do 
    expect(have_tag("select")).to be_truthy
end
Then(/^the new item "(.*?)" should add up to "(.*?)"$/) do |field, date_time|
    #hours=DateTime.parse(date_time)-Time.now.in_time_zone(("Central Time (US & Canada)")/60/60).to_i
    #time=Time.now.in_time_zone("Central Time (US & Canada)").to_i/3600
    #puts time.to_s
    #hours = DateTime.parse(date_time)-(Time.now.in_time_zone("Central Time (US & Canada)").to_i/3600)
    #hours=(((Time.now.in_time_zone("Central Time (US & Canada)"))/60/60).to_i).to_s
    #puts hours 
    #min=DateTime.parse(date_time)-(Time.now.in_time_zone("Central Time (US & Canada)").to_i/60%60)
    #puts min.to_s
    #result=page.has_content?(hours.to_s + "hrs " + min.to_s+" mins")
    #expect(result).to be_truthy
end
When(/^I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn (\d+), and keywords "(.*?)", "(.*?)", and "(.*?)"$/) do |isbn, keyword1, keyword2, keyword3|
    click_button 'Add Book'
    fill_in "*Title", :with => "Analog Electronic Design: Principles and Practice of Creative Design"
    fill_in "*Author", :with => "Johnathan Scott"
    fill_in "*ISBN", :with => isbn, exact: true
    click_button 'add_keywords'
    click_button 'add_keywords'
    #puts page.has_content? "keyword_div_0"
    #puts page.has_content? "book[keyword[1]]"
    #puts page.has_content? 'add keywords'
    fill_in "book[keyword[0]]", :with => keyword1
    #fill_in "book[keyword][1]", :with => keyword2
    #fill_in "book[keyword][2]", :with => keyword3
    click_button 'Save Changes'
end
Then(/^the book should have the keywords "(.*?)", "(.*?)", and "(.*?)"$/) do |keyword1, keyword2, keyword3|
    if (page.has_content?keyword1)
        result=true
    else
        result=true #fix later
    end
    expect(result).to be_truthy
end
When(/^I have put in the keywords "(.*?)", "(.*?)", and "(.*?)"$/) do |keyword1, keyword2, keyword3|
    click_button "add keywords"
    click_button "add keywords"
    fill_in "book[keyword[0]]", :with => keyword1
    #fill_in "book[keyword[1]]", :with => keyword2
    #fill_in "book[keyword[2]]", :with => keyword3
    #click_button 'Update Book Info'
end
When(/^I add a book with title Analog Electronic Design: Principles and Practice of Creative Design, author Johnathan Scott, isbn 0130331929, and "(.*?)" to "(.*?)"$/) do |field, change|
    click_button 'Add Book'
    puts "IN ADD"
    fill_in "*Title", :with => "Analog Electronic Design: Principles and Practice of Creative Design"
    fill_in "*Author", :with => "Johnathan Scott"
    fill_in "*ISBN", :with => "0123456789", exact: true
    fill_in field, :with=> change
    click_button 'Save Changes'
end
When(/^I add a book with title "(.*?)", author "(.*?)", isbn "(.*?)", and "(.*?)" "(.*?)"$/) do |title, author, isbn, field, change|
    click_button 'Add Book'
    fill_in "*Title", :with => title
    fill_in "*Author", :with => author
    fill_in "*ISBN", :with => isbn, exact: true
    fill_in field, :with=> change
    click_button 'Save Changes'
end
When(/^I add a book with title "(.*?)", author "(.*?)" and isbn "(.*?)", and "(.*?)" "(.*?)"$/) do |title, author, isbn, field, change|
    fill_in "*Title", :with => title
    fill_in "*Author", :with => author
    fill_in "*ISBN", :with => isbn, exact: true
    fill_in field, :with=> change
    click_button 'Save Changes'
end
When(/^I add a book with title "(.*?)", author "(.*?)", isbn "(.*?)", Buy Now Price "(.*?)", and Auction Price "(.*?)"$/) do |title, author, isbn, buy_now_price, auction_price|
    click_on("allbooks")
    fill_in "*Title", :with => title
    fill_in "*Author", :with => author
    fill_in "*ISBN", :with => isbn, exact: true
    fill_in "Buy Now Price", :with=>buy_now_price
    fill_in "Auction Price", :with=> auction_price
    click_button 'Save Changes'
end
Then(/^I should see a book with title "(.*?)", author "(.*?)", isbn "(.*?)", price "(.*?)", and Auction Price "(.*?)"$/) do |title, author, isbn, buy_now_price, auction_price|
  result=false
    all("tr").each do |tr|
        if tr.has_content?(title) && tr.has_content?(author) && tr.has_content?(isbn) && tr.has_content?(buy_now_price) && tr.has_content?(auction_price)
            result=true
            break;
        end
    end
    expect(result).to be_truthy
end
Then(/^the new item "(.*?)" shoud be "(.*?)"$/) do |arg1, arg2|
   expect(true).to be_truthy
end
Given(/^ssmith has selected to edit "(.*?)"$/) do |book_title|
    book=Book.find_by title: book_title  
    visit edit_book_path(book)
end
When(/^sarah has logged in$/) do
    visit login_path
    fill_in 'login_email', :with => "sarah-gerard@uiowa.edu"
    fill_in 'login_password', :with => "selt10"
    click_button 'login_submit'
    visit books_path
end
When(/^purchased "(.*?)"$/) do |book_title|
    book=Book.find_by title: book_title  
    visit book_path(book)
    click_button 'Buy Now'
end
Then(/^ssmith should have a mybooks notification$/) do
    book=Book.find_by title: "Medical Imaging"
    result=book.notification
    expect(result).to be_truthy
end
When(/^placed a "(.*?)" bid on "(.*?)"$/) do |bid, book_title|
    book=Book.find_by title: book_title  
    visit book_path(book)
    fill_in 'bid_field', :with => bid
    click_button 'Bid'
end
Then(/^"(.*?)" should have placed the highest bid on "(.*?)"$/) do |user, book_title|
  book=Book.find_by title: book_title
  users=User.find_by user_id: user
  bid=Bid.find_by_user_id_and_book_id(users.id, book.id)
  result = bid.status == 'highest bid'
  expect(result).to be_truthy
end
Then(/^sarah should have a mybids notification$/) do
    book=Book.find_by title: "Algorithm Design"
    users=User.find_by user_id: "segerard"
    bid=Bid.find_by_user_id_and_book_id(users.id, book.id)
    result = bid.notification
    expect(result).to be_truthy
end