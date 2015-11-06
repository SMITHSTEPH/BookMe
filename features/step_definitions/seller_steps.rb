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

Then /^I should see all of the books I am selling$/ do
    result=false
    row_count=0
     all("tr").each do |tr|
        row_count+=1
     end
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
end

Then /the "(.*?)" of "(.*?)" should be "(.*?)"$/ do |field, title, change|
    result=false
    all("tr").each do |tr|
        if tr.has_content?(change) && tr.has_content?(title)
            result=true
            break;
        end
    end
    expect(result).to be_truthy
end

When /I add a book with title "(.*?)", author "(.*?)" and isbn "(.*?)"$/ do |title, author, isbn|
    click_button 'Add Book'
    fill_in "* Title", :with => title
    fill_in "* Author", :with => author
    fill_in "* ISBN", :with => isbn, exact: true
    click_button 'Save Changes'
end
Then /I should see a book with title "(.*?)", author "(.*?)" and isbn "(.*?)" added mybooks$/ do |title, author, isbn|
    result=false
    all("tr").each do |tr|
        if tr.has_content?(title) && tr.has_content?(author) && tr.has_content?(isbn)
            result=true
            break;
        end
    end
    expect(result).to be_truthy
end

When /I remove a book with title "(.*?)"$/ do |title|
     book=Book.find_by_title(title)   
     puts book.title.to_s
     Capybara.current_session.driver.delete book_path(book.id)
     visit mybooks_path

end
Then /I should not see a book with title "(.*?)" in MyBooks$/ do |title|
    result=false
    all("tr").each do |tr|
        result=true
        if tr.has_content?(title)
            puts "in the for loop"
            result=false
            break;
        end
    end
    expect(result).to be_truthy
end

Then /I should see flash message "(.*?)"$/ do |message|
    result= page.has_content? message
    expect(result).to be_truthy
end