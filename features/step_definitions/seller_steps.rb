Given /^sgerard is on the BookMe homepage$/ do
 visit books_path
end

Given /^sgerard is selling the following books:$/ do |books_table|
    Book.delete_all
    books_table.hashes.each do |book|
        #puts "book is: "
        #puts book
        Book.find_or_create_by book
    end
end

When /^I click on button mybooks to see my books$/ do
    #click_button 'My Books'
end

Then /^I should see all of the books I am selling$/ do
    result=false
    row_count=0
     all("tr").each do |tr|
        row_count+=1
     end
     puts "row_count "+ row_count.to_s
     puts "movie_count "+ Book.count.to_s
     if Book.count == row_count-1 #get rid of the title row
         result=true
     else
         result=false
     end
    expect(result).to be_truthy
end