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

Given(/^frodo is on the all books page$/) do
  visit login_path
end

When(/^frodo searches for a book by "(.*?)"$/) do |keyword|
    fill_in 'search_term', :with => "keyword"
    click_button 'search_submit'
end

Then(/^frodo sees a list with book "(.*?)"$/) do |title|
    result = page.has_content? title
    expect(result).to be_truthy
end