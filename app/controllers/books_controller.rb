class BooksController < ApplicationController
  before_filter :set_current_user
  helper_method :sort_column, :sort_direction
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :department, :course, :quality, :price, :auction_start_price, :auction_time, :description, :image, :keyword, :time_left, :bid_price)
  end

  def update_time(id)
    @book = Book.find(id) # look up book by unique ID
    if @book.status == "sold"
      @book.update_attribute(:time_left, "sale ended")
    else
    time_diff = @book.auction_time-Time.now.in_time_zone("Central Time (US & Canada)")
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
        bidder = User.find_by_user_id(@book.bidder_id)
        seller = User.find(@book.user_id)
        bidder.update_attribute(:books_bought, (bidder.books_bought)+1)
        seller.update_attribute(:books_sold, (seller.books_sold)+1)
      end
    else
      @book.update_attribute(:status, "auction")
    end
    @book.update_attribute(:time_left, days + " days " + hours + " hrs " + mins + " mins")
    end
  end  

  def show #displayed when user clicks on book title link
    id = params[:id] # retrieve book ID from URI route
    @book = Book.find(id) # look up book by unique ID
    update_time(id)
    
    if Tag.find_by(book_id: @book.id) #getting the keywords if there are any
      @keywords = Array.new
      Tag.find_each do |keyword|
        if keyword.book_id == @book.id
          @keywords << keyword
        end
      end
    else
      @keywords = { }
    end # will render app/views/books/show.<extension> by default
  end

  def index #rendered when user clicks on 'allBooks'
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:title => :asc}, 'hilite'
    when 'price'
      ordering,@price_header = {:price => :asc}, 'hilite'
    when 'auctionPrice'
      ordering,@auctionPrice_header = {:auction_start_price => :asc}, 'hilite'
    when 'author'
      ordering,@author_header = {:author => :asc}, 'hilite'
    end
    @books = Book.search(params[:search]).order(sort_column + ' ' + sort_direction)-Book.where(status:"sold")
    session[:session_token]= @current_user.user_id
  end


  def mybooks #routed here when user hits "mybooks" button and renders mybooks view
    @user = User.find(@current_user.id.to_s)
    @books = @user.books.search(params[:search])-Book.where(status:"sold")
    params.each do |p|
      puts p.to_s
    end
  end
  
  def mybids #routed here when user hits "mybooks" button and renders mybooks view
    @user = User.find(@current_user.id.to_s)
    #@books = @user.books.search(params[:search])
    @books = Book.where(bidder_id:@user.user_id).where(status:"auction")
    @books.each do |book|
      update_time(book.id)
      puts book.bid_price
    end
    @booksBought = Book.where(bidder_id:@user.user_id).where(status:"sold")
    params.each do |p|
      puts p.to_s
    end
  end

  def new #routed here when user hits 'add book' button and renders new view
    keywords={"0"=>""}
    @book={:title => "", :author => "", :isbn => "", :department => "", :course => "", :price => "", :auction_start_price => "", :auction_time => "", :quality => "", :image => "nobook.gif", :description => "", :keyword => keywords, :time_left=> ""}

    # default: render 'new' template
  end


  def search_open_lib #routed here when user looks up book isbn and renders new view
    @isbn = params[:book][:isbn_open_lib]
    @book=Book.open_lib_find_book(@isbn)

    if @book.empty?
      flash[:warning] = "Book not found in database!"
    end
    keywords={"0"=>""}
    @book[:keyword]=keywords
    render new_book_path 
  end


  def create #routed here when user saves changes on added book and redirects to index
    @info = book_params
    keywords=params[:book][:keyword]
    puts "IN CREATE!!"
    if @info[:image].to_s.empty?
      @info[:image]="nobook.gif"
    end

    @info[:isbn]=@info[:isbn].gsub(/[-' ']/,'')
#    if @info[:price]==""
#      @info[:price]="0.00"
#    end
    if @info[:auction_start_price]==""
      @info[:auction_start_price]=@info[:price]
    end
    @info[:bid_price]=@info[:auction_start_price]
    @info[:status]= "auction"

    @info["auction_time(1i)"]=params["book"]["auction_time"]["{}(1i)"]
    @info["auction_time(2i)"]=params["book"]["auction_time"]["{}(2i)"]
    @info["auction_time(3i)"]=params["book"]["auction_time"]["{}(3i)"]
    @info["auction_time(4i)"]=params["book"]["auction_time"]["{}(4i)"]
    @info["auction_time(5i)"]=params["book"]["auction_time"]["{}(5i)"]
    testbook = Book.new(@info)

    if(testbook.valid?)
      book = @current_user.books.create!(@info)
      flash[:notice] = "#{book.title} was successfully added."
      keywords.each do |key, value| #adding all of the keywords to the keyword database
        Tag.create!({:book_id => book.id, :tag => value})
        puts "created keyword: " + value
      end
      redirect_to mybooks_path
    else
#      @info[:auction_time]=@info[:auction_time].to_s
      @book=@info
      @book[:keyword]=keywords
      messages = testbook.errors.full_messages
      flash[:warning] = messages.join("<br/>").html_safe
      render new_book_path
    end
  end



  def edit #routes here when you click the 'edit' button from the mybooks view and renders edit view
    @book = Book.find params[:id]
    @keywords = []
    puts "is empty?"
    puts @keywords.empty?
    if Tag.find_by(book_id: @book.id.to_s) #getting the keywords if there are an
      puts "id is: " +  @book.id.to_s
      Tag.find_each  do |keyword|
        if keyword.book_id == @book.id
          puts "in if keyword matches"
           @keywords << keyword
        end
      end
    end
  end
  

  def update #routes here when you click 'Update info' button on edit view and redirects show
    @info = book_params
    keywords=params[:book][:keyword]
    @info[:isbn]=@info[:isbn].gsub(/[-' ']/,'')
    
    @info["auction_time(1i)"]=params["book"]["auction_time"]["{}(1i)"]
    @info["auction_time(2i)"]=params["book"]["auction_time"]["{}(2i)"]
    @info["auction_time(3i)"]=params["book"]["auction_time"]["{}(3i)"]
    @info["auction_time(4i)"]=params["book"]["auction_time"]["{}(4i)"]
    @info["auction_time(5i)"]=params["book"]["auction_time"]["{}(5i)"]
    
    if @info[:price]==""
      @info[:price]="0.00"
    end
    if @info[:auction_start_price]==""
      @info[:auction_start_price]="0.00"
    end
    testbook = Book.new(@info)
    if(testbook.valid?)
      @book = Book.find params[:id]
      @book.update_attributes!(@info)

      Tag.delete_all(book_id: @book.id) #deleting all of the keysword for this book
       keywords.each do |key, value| #adding all of the keywords to the keyword database

        Tag.create!({:book_id => @book.id, :tag => value}) #adding in the new keywords
      end
      flash[:notice] = "#{@book.title} was successfully updated."
      redirect_to book_path(@book)
    else 
      messages = testbook.errors.full_messages
      flash[:warning] = messages.join("<br/>").html_safe
      redirect_to edit_book_path
    end
  end

  def destroy #routes here when you click 'delete' on mybooks view and redirects to index method
    @book = Book.find(params[:id])
    Tag.delete_all book_id: @book.id
    @book.destroy
    flash[:notice] = "'#{@book.title}' deleted."
    redirect_to mybooks_path
  end

  def buy_now
    @book = Book.find(params[:id])
    if @book[:status]=="sold"
      flash[:notice] = "Sorry '#{@book.title}' already sold."
      redirect_to book_path
    else
      @book.update_attribute(:bidder_id, @current_user[:user_id])
      @book.update_attribute(:status, "sold")
      bidder = User.find_by_user_id(@book.bidder_id)
      seller = User.find(@book.user_id)

      bidder.update_attribute(:books_bought, (bidder.books_bought)+1)
      seller.update_attribute(:books_sold, (seller.books_sold)+1)
      
      flash[:notice] = "You have purchased "+@book.title+". Thank you!"
      redirect_to books_path
    end
  end

  def make_bid
    @book = Book.find(params[:id])
    @info = book_params
    if @info[:status]=="sold"
      flash[:notice] = "Sorry '#{@book.title}' already sold."
      redirect_to book_path
    else
      if (@info[:bid_price]=~/\A[0-9]+\.?[0-9]*\z/) == 0
        if @info[:bid_price].to_f > @book[:bid_price].to_f
          if @book[:status]=="auction"
            @book.update_attribute(:bid_price, @info[:bid_price])
            @book.update_attribute(:bidder_id, @current_user[:user_id])
            flash[:notice] = "$"+@book.bid_price+" bid made for "+@book.title
            redirect_to books_path
          else
            flash[:notice] = "Sorry, auction has ended."
            redirect_to book_path
          end  
        else
          flash[:notice] = "Bid must be greater than current bid."
          redirect_to book_path
        end
      else
        flash[:notice] = "Invalid bid price."
        redirect_to book_path
      end
    end
  end
  
  private
  def sort_column
    params[:sort] || "title"
  end
  
  def sort_direction
    params[:direction] || "asc"
  end
end
