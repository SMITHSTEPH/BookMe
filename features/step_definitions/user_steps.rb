Given(/^I am on the edit account page$/) do
  visit new_user_path
  fill_in 'signup_first_name', :with => "Blake"
  fill_in 'signup_last_name', :with => "Dunham"
  fill_in 'signup_email', :with => "g@g.com"
  fill_in 'signup_id', :with => "dnham54"
  fill_in 'signup_password', :with => "password"
  fill_in 'signup_password_confirmation', :with => "password"
  click_button 'signup_submit'
  fill_in 'login_email', :with => "g@g.com"
  fill_in 'login_password', :with => "password"
  click_button 'login_submit'
  visit edit_user_path "1"

end

When(/^I edit an account with firstName "(.*?)", lastName "(.*?)", user_id "(.*?)", email "(.*?)", password "(.*?)", confirmPassword "(.*?)"$/) do |firstName, lastName, email, user_id, password, confirmPassword|
  fill_in 'edit_first_name', :with => firstName
  fill_in 'edit_last_name', :with => lastName
  fill_in 'edit_email', :with => email
  fill_in 'edit_id', :with => user_id
  fill_in 'edit_password', :with => password
  fill_in 'edit_password_confirmation', :with => confirmPassword

  click_button 'edit_submit'
end

Then(/^I should go to my books page$/) do
    result=false
    if page.has_button?('edit_submit')
        result = true;
    end
    expect(result).to be_truthy
end

When(/^I edit an account with no parameters$/) do
     click_button 'edit_submit'
end

Then(/^I should return to user edit page$/) do
  result=false
  if page.has_button?('edit_submit')
      result = true;
  end
  expect(result).to be_truthy
end

Given(/^the following books have been added to BookMe:$/) do |table|
    table.hashes.each do |book|
    Book.find_or_create_by(title: book[:title], author: book[:author], price: book[:price], bid_price: book[:bid_price], auction_start_price: book[:auction_price])
  end
end

Given(/^I am on the BookMe home page$/) do
    visit books_path
end

When(/^I have sorted books by title$/) do
  if page.has_link?('Book Title') 
    page.click_on('Book Title')
  end
end

Then(/^I should see book title "(.*?)" before "(.*?)"$/) do |arg1, arg2|
    result = true
    count = 0
    all("tr").each do |tr|
        if tr.has_content?(arg1)
            count = 1
            result = true
        elsif tr.has_content?(arg2) && count == 0
            result = false
        end
    end
    expect(result).to be_truthy
end

When(/^I have sorted books by author$/) do
  if page.has_link?('Author') 
    page.click_link('Author')
  end
end

Then(/^I should see author "(.*?)" before "(.*?)"$/) do |arg1, arg2|
      result = true
    count = 0
    all("tr").each do |tr|
        if tr.has_content?(arg1)
            count = 1
            result = true
        elsif tr.has_content?(arg2) && count == 0
            result = false
        end
    end
    expect(result).to be_truthy
end

When(/^I have sorted books by buy now price$/) do
  if page.has_link?('Buy Now Price') 
    page.click_link('Buy Now Price')
  end
end

Then(/^I should see price "(.*?)" before "(.*?)"$/) do |arg1, arg2|
      result = true
    count = 0
    all("tr").each do |tr|
        if tr.has_content?(arg1)
            count = 1
            result = true
        elsif tr.has_content?(arg2) && count == 0
            result = false
        end
    end
    expect(result).to be_truthy
end

When(/^I have sorted books by auction price$/) do
  if page.has_link?('Auction Price') 
    page.click_link('Auction Price')
  end
end

Then(/^I should see auction price "(.*?)" before "(.*?)"$/) do |arg1, arg2|
    result = true
    count = 0
    all("tr").each do |tr|
        if tr.has_content?(arg1)
            count = 1
            result = true
        elsif tr.has_content?(arg2) && count == 0
            result = false
        end
    end
    expect(result).to be_truthy
end



Given /^I am on the BookMe user page$/ do
  visit book_path
 end

 When /^I have added a book with title "(.*?)", author "(.*?)", isbn "(.*?)", quality "(.*?)", and price "(.*?)"$/ do |title, author, isbn, quality, price|
  visit new_book_path
  fill_in 'Title', :with => title
  fill_in 'Author', :with => author
  fill_in 'ISBN', :with => isbn
  fill_in 'Quality', :with => quality
  fill_in 'Price', :with => price
  click_button 'Save Changes'
 end

 Then /^I should see a book listed for sale with title "(.*?)", author "(.*?)", isbn "(.*?)", quality "(.*?)", and price "(.*?)"$/ do |title, author, isbn, quality, price|
   result=false
   all("tr").each do |tr|
     if (tr.has_content?(title) && tr.has_content?(author) && tr.has_content?(isbn) && tr.has_content?(quality) && tr.has_content?(price))
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end
 
 Given /^I am on the create account page$/ do 
     visit new_user_path
 end
 
 When(/^I create an account with firstName "(.*?)", lastName "(.*?)", user_id "(.*?)", email "(.*?)", password "(.*?)", confirmPassword "(.*?)"$/) do |firstName, lastName, user_id, email, password, confirmPassword|
  fill_in 'signup_first_name', :with => firstName
  fill_in 'signup_last_name', :with => lastName
  fill_in 'signup_email', :with => email
  fill_in 'signup_id', :with => user_id
  fill_in 'signup_password', :with => password
  fill_in 'signup_password_confirmation', :with => confirmPassword

  click_button 'signup_submit'
 end
 
Then /I should see a flash message "(.*?)"$/ do |message|
    result= page.has_content? message
    expect(result).to be_truthy
end 


 When(/^I create an account with no parameters$/) do
     click_button 'signup_submit'
 end
 
 Then /I should see a message "(.*?)"$/ do |message|
    result= page.has_content? message
    expect(result).to be_truthy
end 



Given(/^I am on the login page and have an account$/) do
  visit new_user_path
  fill_in 'signup_first_name', :with => "Blake"
  fill_in 'signup_last_name', :with => "Dunham"
  fill_in 'signup_email', :with => "b@b.com"
  fill_in 'signup_id', :with => "bdunham"
  fill_in 'signup_password', :with => "password"
  fill_in 'signup_password_confirmation', :with => "password"
  click_button 'signup_submit'
end

When(/^I login with email "(.*?)" and password "(.*?)"$/) do |email, password|
  fill_in 'login_email', :with => email
  fill_in 'login_password', :with => password
  click_button 'login_submit'
end

Then(/^I should see the flash message "(.*?)"$/) do |message|
  result= page.has_content? message
  expect(result).to be_truthy
end

When(/^I try to login with email "(.*?)" and password "(.*?)"$/) do |email, password|
  fill_in 'login_email', :with => email
  fill_in 'login_password', :with => password
  click_button 'login_submit'
end

Then(/^I should see the message "(.*?)"$/) do |message|
  result= page.has_content? message
  expect(result).to be_truthy
end

When(/^frodo searches for a book by "(.*?)"$/) do |search|
    visit books_path
    if page.has_content? "search"
        fill_in "search", :with => search
        click_button "search_submit"
    end
end

Then(/^frodo sees a list with book "(.*?)"$/) do |title|
    if page.has_content? title
        result = page.has_content? title
        expect(result).to be_truthy
    end
end