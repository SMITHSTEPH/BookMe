class Book < ActiveRecord::Base
  
  belongs_to :user 

  VALID_EMAIL_REGEX = /\A[0-9]{9,13}\z/
  validates :isbn, presence: true,
                   format: {with: VALID_EMAIL_REGEX}
  validates :title, presence:true
  validates :author, presence:true

  def self.search(search)
    if search
      self.where("title like :query OR isbn like :query", query: "%#{search}%")    
    else
      self.all
    end
  end
  
  def self.open_lib_find_book(isbn)
    view = Openlibrary::View
    book_view = view.find_by_isbn(isbn)
    data = Openlibrary::Data
    book_data = data.find_by_isbn(isbn)
    
    if book_data == nil
      @book = {}
    else   
      book_title = book_data.title
      if book_data.authors == nil
        book_author = ""
      else
        book_author = book_data.authors[0]["name"]
      end
      book_image = book_view.thumbnail_url
      if(book_image==nil || book_image.empty?)
        @book = {title:book_title, author:book_author, isbn:isbn, image:"nobook.gif", price:"", quality:""}
      else
      @book = {title:book_title, author:book_author, isbn:isbn, image:book_image, price:"", quality:""}
      end
    end 
    @book
  end


end
