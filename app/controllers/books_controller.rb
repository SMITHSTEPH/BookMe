class BooksController < ApplicationController
  before_filter :set_current_user
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :department, :course, :quality, :price, :auction_start_price, :auction_time, :description, :image, :time_left)
  end

  def show #displayed when user clicks on book title link
    id = params[:id] # retrieve book ID from URI route
    @book = Book.find(id) # look up book by unique ID
    unless @book.auction_time.nil?
      hours = (((@book.auction_time-Time.now)/60/60).to_i).to_s
      mins = (((@book.auction_time-Time.now)/60%60).to_i).to_s
      if(hours.to_i<0)
        hours="0"
        mins="0"
      end
#      @book[:time_left]= hours + " hrs " + mins +" mins"
      @book.update_attribute(:time_left, hours + " hrs " + mins +" mins")
    end
    # will render app/views/books/show.<extension> by default
  end

  def index #rendered when user clicks on 'myBooks'
    @books = Book.search(params[:search])
    session[:session_token]= @current_user.user_id
    puts @current_user.user_id
  end
  
  def mybooks #routed here when user hits "mybooks" button and renders mybooks view
    @user = User.find_by_id(@current_user.id)
    @books = @user.books
  end

  def new #routed here when user hits 'add book' button and renders new view
    @book={:title => "", :author => "", :isbn => "", :department => "", :course => "", :price => "", :auction_start_price => "", :auction_time => "", :quality => "", :image => "nobook.gif", :description => "", :time_left => ""}
    # default: render 'new' template
  end
  def search_open_lib #routed here when user looks up book isbn and renders new view
    @isbn = params[:book][:isbn_open_lib]
    @book=Book.open_lib_find_book(@isbn)

    if @book.empty?
      flash[:warning] = "Book not found in database!"
    end
    render new_book_path 
  end

  def create #routed here when user saves changes on added book and redirects to index
    @info = book_params
    if @info[:image].to_s.empty?
      @info[:image]="nobook.gif"
    end
    @info[:isbn]=@info[:isbn].gsub(/[-' ']/,'')
    unless @info[:auction_time].empty?
      begin
        @info[:auction_time]=Time.parse(@info[:auction_time])
        hours = (((@info[:auction_time]-Time.now)/60/60).to_i).to_s
        mins = (((@info[:auction_time]-Time.now)/60%60).to_i).to_s
        if(hours.to_i<0)
          hours="0"
          mins="0"
        end
        @info[:time_left]= hours + " hrs " + mins +" mins"
        
      rescue
        flash[:warning] = "Invalid auction time."
        @info[:auction_time]=""
        @book=@info
        render new_book_path
        return
      end
    end
    testbook = Book.new(@info)
    if(testbook.valid?)
      book = @current_user.books.create!(@info)
      flash[:notice] = "#{book.title} was successfully added."
      redirect_to mybooks_path
    else
      @info[:auction_time]=@info[:auction_time].to_s
      @book=@info
      messages = testbook.errors.full_messages
      flash[:warning] = messages.join("<br/>").html_safe
      render new_book_path
    end
  end

  def edit #routes here when you click the 'edit' button from the mybooks view and renders edit view
    @book = Book.find params[:id]
  end

  def update #routes here when you click 'Update info' button on edit view and redirects show
    @info = book_params
    @info[:isbn]=@info[:isbn].gsub(/[-' ']/,'')
    unless @info[:auction_time].empty?
      begin
        @info[:auction_time]=Time.parse(@info[:auction_time])
        hours = (((@info[:auction_time]-Time.now)/60/60).to_i).to_s
        mins = (((@info[:auction_time]-Time.now)/60%60).to_i).to_s
        if(hours.to_i<0)
          hours="0"
          mins="0"
        end
        @info[:time_left]= hours + " hrs " + mins +" mins"
      rescue ArgumentError
        flash[:warning] = "Invalid auction time."
        redirect_to edit_book_path
        return
      end
    end
    testbook = Book.new(@info)
    if(testbook.valid?)
      @book = Book.find params[:id]
      @book.update_attributes!(@info)
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
    @book.destroy
    flash[:notice] = "'#{@book.title}' deleted."
    redirect_to mybooks_path
  end

end
