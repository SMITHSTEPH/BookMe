class BooksController < ApplicationController
  #before_filter :set_current_user
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :quality, :price, :description, :image)
  end

  def show
    id = params[:id] # retrieve book ID from URI route
    @book = Book.find(id) # look up book by unique ID
    # will render app/views/books/show.<extension> by default
  end

  def index #rendered when user clicks on 'myBooks'
    session[:session_token]='segerard' #hardcoding segerard as user now
    @books = Book.all
  end
  
  def mybooks #routed here when user hits "mybooks" button and renders mybooks view
    @books = Book.where(seller:session[:session_token])
  end

  def new #routed here when user hits 'add book' button and renders new view
    puts "goes in right controller 2"
    @book={:title => "", :author => "", :isbn => "", :price => "", :quality => "", :image => ""}
    # default: render 'new' template
  end
  def search_open_lib #routed here when user looks up book isbn and renders new view
    puts "goes in right controller 1"
    @book=Book.open_lib_find_book book_params[:isbn]
    puts "params are: " + book_params[:isbn].to_s
    if @book.empty?
      flash[:warning] = "Invalid ISBN, book not found!"
    end
    render "books/new.html.haml"
  end

  def create #routed here when user saves changes on added book and redirects to index?
    info = book_params
    info[:seller] = session[:session_token]
    puts info[:image]
    @book = Book.create!(info)
    flash[:notice] = "#{@book.title} was successfully added."
    redirect_to books_path
  end

  def edit #routes here when you click the 'edit' button from the mybooks view and renders edit view
    @book = Book.find params[:id]
  end

  def update #routes here when you click 'save changes' after editing and redirects to index?
    @book = Book.find params[:id]
    puts "BOOKS ARE:"
    puts @book.to_s
    puts "vs books params"
    puts book_params.to_s
    @book.update_attributes!(book_params)
    puts "title is: " + book_params[:title].to_s
    #puts "author is: " + book_params[:author][:author].to_s
    puts @book.to_s
    flash[:notice] = "#{@book.title} was successfully updated."
    redirect_to book_path(@book)
  end

  def destroy #routes here when you click 'delete' on mybooks view and redirects to index method
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "'#{@book.title}' deleted."
    redirect_to books_path
  end

end
