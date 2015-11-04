class BooksController < ApplicationController
  #before_filter :set_current_user
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :quality, :price, :description)
  end

  def show
    id = params[:id] # retrieve book ID from URI route
    @book = Book.find(id) # look up book by unique ID
    # will render app/views/books/show.<extension> by default
  end

  def index
    session[:session_token]='segerard'
    @books = Book.all
  end
  
  def mybooks
    @books = Book.where(seller:session[:session_token])
  end

  def new
    puts "goes in right controller 2"
    # default: render 'new' template
  end
  def search_open_lib
    puts "goes in right controller 1"
    #@book=open_lib_find_book params[:isbn]
    redirect_to new_book_path
  end

  def create
    info = book_params
    info[:seller] = session[:session_token]
    @book = Book.create!(info)
    flash[:notice] = "#{@book.title} was successfully added."
    redirect_to books_path
  end

  def edit #routes here when you click the edit button
    @book = Book.find params[:id]
  end

  def update
    @book = Book.find params[:id]
    @book.update_attributes!(book_params)
    flash[:notice] = "#{@book.title} was successfully updated."
    redirect_to book_path(@book)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "'#{@book.title}' deleted."
    redirect_to books_path
  end

end
