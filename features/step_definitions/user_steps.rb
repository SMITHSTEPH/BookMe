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