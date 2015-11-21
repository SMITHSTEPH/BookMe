Given /^ssmith32 is selling the following books:$/ do |books_table|

    puts "in selling the following books"
    @user=User.find_by_email('stephanie-k-smith@uiowa.edu')
    puts "user is " + @user.id.to_s
    Tag.delete_all
    b = Tag.all
    puts "theres should be no books left in the db:"
    b.each do |i|
        puts "b: " + i.title
    end
    books_table.hashes.each do |book|
        book[:user_id]=@user.id
        Book.create(book)
    end
    @books=Book.where("user_id=="+@user.id.to_s).all
    @books.each do |book| #printing stuff out to test
        puts "id: " + book.user_id.to_s
        puts "title: " + book.title
    end
end
Given /^that ssmith32 has logged in$/ do
    @user=User.new({first_name:'Stephanie', last_name:'Smith',password:'password', password_confirmation:'password', user_id:'ssmith32', email:'stephanie-k-smith@uiowa.edu'})
    @user.save
    visit login_path
    fill_in 'login_email', :with => "stephanie-k-smith@uiowa.edu"
    fill_in 'login_password', :with => "password"
    click_button 'login_submit'
    visit books_path
end
Given /^ssmith32 is on the MyBooks page$/ do
    visit mybooks_path
end
Given /^ssmith32 is viewing the book$/ do
    
end
Given /ssmith32 has selected to edit "(.*?)"$/ do |book_title|
    
    book=Book.find_by title: book_title   
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
Then /the new item "(.*?)" should be "(.*?)"$/ do |field, change|
    puts "in this test"
    result= page.has_content? change
    expect(result).to be_truthy
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
    #visit new_book_path
    fill_in "*Title", :with => title
    fill_in "*Author", :with => author
    fill_in "*ISBN", :with => isbn, exact: true
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

When /I remove a book with title "(.*?)"$/ do |book_title|
     puts "title is: " + book_title
     @book=Book.find_by! title: book_title
end
Then /I should not see a book with title "(.*?)" in MyBooks$/ do |title|
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

Then /I should see flash message "(.*?)"$/ do |message|
    result= page.has_content? message
    expect(result).to be_truthy
end