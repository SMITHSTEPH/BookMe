Given /^sgerard is on the BookMe homepage$/ do
 visit mybooks_path
end

Given /^sgerard is selling the following books:$/ do |books_table|
    Book.delete_all
    books_table.hashes.each do |book|
        Book.find_or_create_by book
    end
end
Given /^sgerard is on the MyBooks page$/ do
    visit mybooks_path
end

Given /sgerard has selected to edit "(.*?)"$/ do |book_title|

    book=Book.find_by_title(book_title)   
    visit edit_book_path(book)
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
     if Book.count == row_count #get rid of the title row
         result=true
     else
         result=false
     end
    expect(result).to be_truthy
end

When /I change field "(.*?)" to "(.*?)"$/ do |field, change|
    fill_in field, :with => change
    click_button "Update Book Info"
     visit mybooks_path
end

Then /the "(.*?)" of "(.*?)" should be "(.*?)"$/ do |field, title, change|
    result=false
    puts "in then"
    all("tr").each do |tr|
        puts tr.text
        if tr.has_content?(change) && tr.has_content?(title)
            result=true
            break;
        end
    end
    expect(result).to be_truthy
end

Then /I should see the flash warning "(.*?)"$/ do |flash_message|
end