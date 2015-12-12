require 'spec_helper'
require 'rails_helper'
describe BooksController do
  before :each do
    @user=User.new({first_name:'Foo', last_name:'Bar',password:'foobar100', password_confirmation:'foobar100', user_id:'foobar', email:'foobar@uiowa.edu', books_bought:0, books_sold:0})
    @user.save
    @info = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time(1i)"=>"2015", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30", "status"=>"auction", "bidder_id"=>@user.user_id}
    @user.books.create!(@info)
    @userbooks=@user.books
    @bookid = @userbooks[0].id
    cookies.permanent[:session_token] = User.find_by_email('foobar@uiowa.edu').session_token
  end

  describe "Books index" do
    it 'should set session token' do
      get :index    
      expect(session[:session_token]).to eq(@user.user_id)
    end
  end

  describe "Books new" do
    it 'should set session token' do
      @book_param={:title => "", :author => "", :isbn => "", :department => "", :course => "", :price => "", :auction_start_price => "", :auction_time => "", :quality => "", :image => "nobook.gif", :description => "", :keyword => {"0"=>""}, :time_left=> ""}
      get :new    
      expect(assigns(:book)).to eq(@book_param)
    end
  end
  describe "Show and delete book" do
    before :each do
      @book_model = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time(1i)"=>"2015", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30"}
      @book_model_exp = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time(1i)"=>"2010", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30"}
      @book_model_sold = {"title" => "Sold", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time(1i)"=>"2010", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30","bidder_id"=>'foobar'}
      @new_book = Book.new(@book_model)
      @new_book.save
      @new_book_exp = Book.new(@book_model_exp)
      @new_book_exp.save
      @user.books.create!(@book_model_sold)
    end
    it 'should change status to sold' do
      get :show, {:id=>Book.where(:title=>'Sold')[0].id}
#      expect(assigns(:book)).to eq(Book.find(@new_book_sold.id))
    end
    it 'should assign book' do
      Tag.create!({:book_id => @new_book.id, :tag => "book"})
      get :show, {:id=>@new_book.id}
      expect(assigns(:book)).to eq(Book.find(@new_book.id))
    end
    it 'should assign expired book' do
      get :show, {:id=>@new_book_exp.id}
      expect(assigns(:book)).to eq(Book.find(@new_book_exp.id))
    end
    it 'should display flash' do
      delete :destroy, {:id=>@new_book.id}      
      expect(flash[:notice]).to eq("'Book' deleted.")
    end
    it 'should redirect to mybooks path' do
      delete :destroy, {:id=>@new_book.id}      
      expect(response).to redirect_to(mybooks_path)
    end
    it 'should assign books' do
      Tag.create!({:book_id => @new_book.id, :tag => "book"})
      get :edit, {:id=>@new_book.id}
      expect(assigns(:book)).to eq(@new_book)
    end
  end

  describe 'Users books' do
    before :each do
      get :mybooks
    end
    it 'should assign user to the current logged in user' do
      expect(assigns(:user)).to eq(@user)
    end
    it 'should assign books' do
      expect(assigns(:books)).to eq(@userbooks)
    end
    it 'should assign books to be type association' do
      #expect(assigns(:books)).to be_a(Book::ActiveRecord_AssociationRelation)
      expect(assigns(:books)).to be_a(Array)
    end
    it 'should render my books template' do
        expect(response).to render_template('mybooks')
    end
  end
  describe 'Users bids' do
    before :each do
      get :mybids
    end
    it 'should assign user to the current logged in user' do
      expect(assigns(:user)).to eq(@user)
    end
    it 'should assign books' do
      expect(assigns(:books)).to eq(@userbooks)
    end
    it 'should assign books to be type association' do
      expect(assigns(:books)).to be_a(ActiveRecord::Relation)
      #expect(assigns(:books)).to be_a(Array)
    end
    it 'should render my books template' do
        expect(response).to render_template('mybids')
    end
  end
  describe 'Buy now' do
    before :each do
      put :buy_now, {:id=>1}
    end
    it 'should assign books' do
      expect(assigns(:book)).to eq(@userbooks[0])
    end
    it 'should assign books to be type association' do
      #expect(assigns(:books)).to be_a(ActiveRecord::Relation)
    end
    it 'should render my books template' do
      expect(response).to redirect_to(books_path)  
    end
  end
  describe 'make bid' do
    before :each do
      put :make_bid, {:id=>1, :book=>{bid_price:"10.00"}}
    end
    it 'should assign books' do
      expect(assigns(:book)).to eq(@userbooks[0])
    end
    it 'should assign books to be type association' do
      #expect(assigns(:books)).to be_a(ActiveRecord::Relation)
    end
    it 'should render my books template' do
      expect(response).to redirect_to(books_path)  
    end
  end
  describe 'Searching by isbn' do
    before :each do
      @fake_results = {:title => "Bool1", :isbn => "1234567890"}
    end
    it 'should call the model method that performs Openlibrary search' do
      expect(Book).to receive(:open_lib_find_book).with('1234567890').and_return(@fake_results)
      post :search_open_lib, {:book => {"isbn_open_lib" => '1234567890'}}
    end
    describe 'after valid search' do
      before :each do
        allow(Book).to receive(:open_lib_find_book).and_return(@fake_results)
        post :search_open_lib, {:book=>{:isbn => '1234567890'}}
      end
      it 'should select the Search Results template for rendering' do
        expect(response).to render_template('new')
      end
      it 'it should assign fake_results to book' do
        expect(assigns(:book)).to eq(@fake_results)
      end
    end
    describe 'after no matching books search' do
      before :each do
        allow(Book).to receive(:open_lib_find_book).and_return({})
      end  
      it 'should call model method that performs Tmdb search' do
        expect(Book).to receive(:open_lib_find_book)
        post :search_open_lib, {:book => {:isbn => '1234567890'}}
      end
      it 'it should redirect to new page' do
        post :search_open_lib, {:book => {:isbn => '1234567890'}}
        expect(response).to render_template('new')
      end
      it 'should display flash saying no matches found' do
        post :search_open_lib, {:book => {:isbn => '1234567890'}}
        expect(flash[:warning]).to eq("Book not found in database!")
      end
    end
  end
  describe 'adding books' do
    context 'Required fields are filled in' do
      before :each do
        @book_param = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time"=>{"{}(1i)"=>"2015", "{}(2i)"=>"12", "{}(3i)"=>"12", "{}(4i)"=>"12", "{}(5i)"=>"30"},"keyword"=>{"1"=>"book"}}
        @book_model = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time(1i)"=>"2015", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30","bid_price"=>nil, "status"=>"auction",}
        @fake_book_result = double(:book=>{:title => "Book Title"})
        allow(Book).to receive(:create!).with(@book_param).and_return(@fake_book_result)
        allow(@fake_book_result).to receive(:title).and_return('Book')
      end    
      #it 'It should call the Book create method' do
      #  expect(:current_user).to receive(create!).with(@fake_book)
      #  post :create, {:book => @fake_book}
      #end
      it 'should return to movies page' do
        post :create, {:book => @book_param}
        expect(response).to redirect_to(mybooks_path)
      end
      it 'it should make the results available' do
        post :create, {:book => @book_param}
        expect(assigns(:info)).to eq(@book_model)
      end
      it 'should show flash indicating book added' do
        post :create, {:book => @book_param}
        expect(flash[:notice]).to eq("Book was successfully added.")
      end
      it 'should assign auciton start price if it is not set' do
      end
    end
    context 'Missing fields' do
      before :each do
        @book_param = {"title" => "", "author" => "", "isbn" => "", "image" => "nobook.gif", "auction_time"=>{"{}(1i)"=>"2015", "{}(2i)"=>"12", "{}(3i)"=>"12", "{}(4i)"=>"12", "{}(5i)"=>"30"},"keyword"=>{"1"=>"book"}, "auction_start_price"=>""}
        @book_model = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "image" => "nobook.gif", "auction_time(1i)"=>"2015", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30", :auction_start_price=>""}
        @fake_book_result = double(:book=>{:title => ""})
        allow(Book).to receive(:create!).with(@book_param).and_return(@fake_book_result)
        allow(@fake_book_result).to receive(:title).and_return('')
        post :create, {:book => @book_param}
      end
      it 'should return to movies page' do
        expect(response).to render_template('new')
      end
      it 'should show flash indicating empty fields' do
        expect(flash[:warning]).to eq("Isbn can't be blank<br/>Isbn is invalid<br/>Title can't be blank<br/>Author can't be blank<br/>Price can't be blank")
      end
    end
    context 'Missing image' do
      before :each do
        @book_param = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "image" => "", "price"=>"100.00", "auction_time"=>{"{}(1i)"=>"2015", "{}(2i)"=>"12", "{}(3i)"=>"12", "{}(4i)"=>"12", "{}(5i)"=>"30"},"keyword"=>{"1"=>"book"}}
        post :create, {:book => @book_param}
      end
      it 'should fill in image' do
        expect(assigns(:info)[:image]).to eq('nobook.gif')
      end
    end
    context 'Hyphens or spaces in isbn' do
      it 'should remove all hypens and spaces' do
        @book_param = {"title" => "Book", "author" => "Sarah", "isbn" => "1234-567 890", "price"=>"100.00", "image" => "nobook.gif", "auction_time"=>{"{}(1i)"=>"2015", "{}(2i)"=>"12", "{}(3i)"=>"12", "{}(4i)"=>"12", "{}(5i)"=>"30"},"keyword"=>{"1"=>"book"}}
        post :create, {:book => @book_param}
        expect(assigns(:info)[:isbn]).to eq('1234567890')
      end
    end
  end
  describe 'updating books' do
    context 'All fields entered' do
      before :each do
        @book_param = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time"=>{"{}(1i)"=>"2015", "{}(2i)"=>"12", "{}(3i)"=>"12", "{}(4i)"=>"12", "{}(5i)"=>"30"},"keyword"=>{"1"=>"book"}, "auction_start_price"=>""}
        @book_model = {"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "price"=>"100.00", "image" => "nobook.gif", "auction_time(1i)"=>"2015", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30", "auction_start_price"=>""}
        @new_book = Book.new(@book_model)
        @new_book.save
        put :update, {:id=>@new_book.id, :book=>@book_param}
      end
    
      it 'should flash warning' do
        expect(flash[:notice]).to eq("Book was successfully updated.")
      end
      it 'should redirect to book path' do
        expect(response).to redirect_to(book_path(@new_book.id))
      end
    end
    context 'Missing fields' do
      before :each do
        @book_param = {"title" => "", "author" => "Sarah", "isbn" => "1234567890", "image" => "nobook.gif", "auction_time"=>{"{}(1i)"=>"2015", "{}(2i)"=>"12", "{}(3i)"=>"12", "{}(4i)"=>"12", "{}(5i)"=>"30"},"keyword"=>["book"]}
        @book_model = {:id=>2,"title" => "Book", "author" => "Sarah", "isbn" => "1234567890", "image" => "nobook.gif", "auction_time(1i)"=>"2015", "auction_time(2i)"=>"12", "auction_time(3i)"=>"12", "auction_time(4i)"=>"12", "auction_time(5i)"=>"30"}
        new_book = Book.new(@book_model)
        new_book.save
        put :update, {:id=>new_book.id, :book=>@book_param}
      end
      it 'should flash warning' do
        expect(flash[:warning]).to eq("Title can't be blank<br/>Price can't be blank")
      end
      it 'should redirect to edit book path' do
        expect(response).to redirect_to(edit_book_path)
      end
    end
  end
end

