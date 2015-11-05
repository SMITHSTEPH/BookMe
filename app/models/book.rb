class Book < ActiveRecord::Base
  def self.open_lib_find_book(isbn)
 # view = Openlibrary::View
    
    data = Openlibrary::Data
    book_data = data.find_by_isbn(isbn)
    if book_data == nil
      puts "book == nil"
      @book = {}
    else   
      puts "book != nil"
      book_title = book_data.title
      book_author = book_data.authors[0]
      @book = {title:book_title, author:book_author, isbn:isbn, price:"", quality:""}
    end 
    @book
  end

end
