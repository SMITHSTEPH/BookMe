class Book < ActiveRecord::Base
  belongs_to :user 
  belongs_to :tag

  VALID_ISBN_REGEX = /\A[0-9]{10,13}\z/
  validates :isbn, presence: true,
                   format: {with: VALID_ISBN_REGEX}
  validates :title, presence:true
  validates :author, presence:true
  validates :price, presence:true
  
  VALID_PRICE_REGEX = /\A[0-9]*(\.[0-9][0-9])?\z/
  validates :price, format: {with: VALID_PRICE_REGEX}
  validates :auction_start_price, format: {with: VALID_PRICE_REGEX}
  
 #VALID_TIME_REGEX = /\A[0-9]{4}(-[0-9]{2}){2}\s[0-9]{2}(:[0-9]{2}){2}\s\+[0-9]{4}\z/
 # validates :auction_time, format: {with: VALID_TIME_REGEX}
  def self.search(search)
    if search
      #self.where("title like :query OR isbn like :query OR course like :query OR department like :query", query: "%#{search}%").distinct 
      self.joins("Left JOIN tags ON books.id = tags.book_id").where("title like :query OR isbn like :query OR course like :query OR department like :query OR tag like :query", query: "%#{search}%").distinct    

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
  
  def self.update_time(id)
    @book = Book.find(id) # look up book by unique ID
    if @book.status == "sold"
      @book.update_attribute(:time_left, "auction ended")
    else
      time_diff = (@book.auction_time).to_i - Time.now.in_time_zone("Central Time (US & Canada)").to_i
      days = ((time_diff/60/60/24).to_i).to_s
      hours = ((time_diff/60/60%24).to_i).to_s
      mins = ((time_diff/60%60).to_i).to_s
      if(time_diff<0)
        days="0"
        hours="0"
        mins="0"
        if @book[:bidder_id] == nil
          @book.update_attribute(:status, "sale")
        else
          @book.update_attribute(:status, "sold")
          if(Bid.exists?(:book_id => @book.id))
            @bid = Bid.where(:book_id => @book.id)
              @bid.each do |bid|
              bid.update_attribute(:status, "sold") #change status to sold
              bid.update_attribute(:notification, true) #give notification to everyone except the person who bought it
            end
          end
        
          bidder = User.find_by_user_id(@book.bidder_id)
          seller = User.find(@book.user_id)
          bidder.update_attribute(:books_bought, (bidder.books_bought)+1)
          seller.update_attribute(:books_sold, (seller.books_sold)+1)
        end
        if @book.time_left != "auction ended"
          @book.update_attribute(:time_left, "auction ended")
          @book.update_attribute(:notification, true)
        end
      else
        @book.update_attribute(:status, "auction")
        @book.update_attribute(:time_left, days + " days " + hours + " hrs " + mins + " mins")
      end
    end
  end  

end
