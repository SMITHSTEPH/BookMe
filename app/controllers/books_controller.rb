class BooksController < ApplicationController
  before_filter :set_current_user
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :quality, :price, :description, :image)
  end

  def show #displayed when user clicks on book title link
    id = params[:id] # retrieve book ID from URI route
    @book = Book.find(id) # look up book by unique ID
    # will render app/views/books/show.<extension> by default
  end

  def index #rendered when user clicks on 'myBooks'
    @books = Book.search(params[:search])
    session[:session_token]= @current_user.user_id
  end
  
  def mybooks #routed here when user hits "mybooks" button and renders mybooks view
    puts seller:session[:session_token]
    puts seller:session[:session_token]
    @books = Book.where(seller:session[:session_token])
    #puts @book.to_S
    
  end

  def new #routed here when user hits 'add book' button and renders new view
    @book={:title => "", :author => "", :isbn => "", :price => "", :quality => "", :image => "nobook.gif", :description => ""}
    # default: render 'new' template
  end
  def search_open_lib #routed here when user looks up book isbn and renders new view
    @isbn = params[:book][:isbn_open_lib]
    @book=Book.open_lib_find_book(@isbn)

    if @book.empty?
      flash[:warning] = "Book not found in database!"
    end
#    render "books/new.html.haml"
    render new_book_path 
  end

  def create #routed here when user saves changes on added book and redirects to index
    info = book_params
    
    if(info[:title].to_s.empty? || info[:author].to_s.empty? || info[:isbn].to_s.empty?)
      flash[:warning]= "fill out all fields marked with '*' to add book"
      if info[:image].to_s.empty?
        @book={:title => info[:title], :author => info[:author], :isbn => info[:isbn], :price => info[:price], :quality =>info[:quality], :image => "nobook.gif", :description => info[:description]}
      else
        @book={:title => info[:title], :author => info[:author], :isbn => info[:isbn], :price => info[:price], :quality =>info[:quality], :image => info[:image], :description => info[:description]}
      end 
      #render "books/new.html.haml"
      render new_book_path
    else
      if info[:image].to_s.empty?
        info[:image]="nobook.gif"
      end
      info[:seller] = session[:session_token]
      @book = Book.create!(info)
      flash[:notice] = "#{@book.title} was successfully added."
      redirect_to mybooks_path
    end
  end

  def edit #routes here when you click the 'edit' button from the mybooks view and renders edit view
    @book = Book.find params[:id]
  end

  def update #routes here when you click 'Update info' button on edit view and redirects show
    if(book_params[:title].to_s.empty? || book_params[:author].to_s.empty? || book_params[:isbn].to_s.empty?)
      flash[:warning]= "need to have * fields filled out"
      redirect_to edit_book_path
    else
      @book = Book.find params[:id]
      @book.update_attributes!(book_params)
      flash[:notice] = "#{@book.title} was successfully updated."
      redirect_to book_path(@book)
    end
  end

  def destroy #routes here when you click 'delete' on mybooks view and redirects to index method
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "'#{@book.title}' deleted."
    redirect_to mybooks_path
  end

end
