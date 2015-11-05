class Book < ActiveRecord::Base
  def self.open_lib_find_book(isbn)
    view = Openlibrary::View
    book_view = view.find_by_isbn(isbn)
    data = Openlibrary::Data
    book_data = data.find_by_isbn(isbn)
    
    if book_data == nil
      puts "book == nil"
      @book = {}
    else   
      puts "book != nil"
      book_title = book_data.title
      book_author = book_data.authors[0]["name"]
      book_image = book_view.thumbnail_url
      @book = {title:book_title, author:book_author, isbn:isbn, image:book_image, price:"", quality:""}
    end 
    @book
  end
  def self.validate_seller_info
  end

end
