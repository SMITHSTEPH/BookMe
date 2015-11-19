require 'spec_helper'
require 'rails_helper'
describe BooksController do
  before :each do
    @user=User.new({first_name:'Foo', last_name:'Bar',password:'foobar100', password_confirmation:'foobar100', user_id:'foobar', email:'foobar@uiowa.edu'})
    @user.save
    @userbooks=@user.books
    cookies.permanent[:session_token] = User.find_by_email('foobar@uiowa.edu').session_token
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
      expect(assigns(:books)).to be_a(ActiveRecord::Associations::CollectionProxy)
    end
    it 'should render my books template' do
        expect(response).to render_template('mybooks')
    end
  end
  describe 'Searching by isbn' do
    before :each do
      @fake_results = {:title => "Bool1", :isbn => "123456789"}
    end
    it 'should call the model method that performs Openlibrary search' do
      expect(Book).to receive(:open_lib_find_book).with('123456789').and_return(@fake_results)
      post :search_open_lib, {:book => {"isbn_open_lib" => '123456789'}}
    end
    describe 'after valid search' do
      before :each do
        allow(Book).to receive(:open_lib_find_book).and_return(@fake_results)
        post :search_open_lib, {:book=>{:isbn => '123456789'}}
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
        post :search_open_lib, {:book => {:isbn => '123456789'}}
      end
      it 'it should redirect to new page' do
        post :search_open_lib, {:book => {:isbn => '123456789'}}
        expect(response).to render_template('new')
      end
      it 'should display flash saying no matches found' do
        post :search_open_lib, {:book => {:isbn => '123456789'}}
        expect(flash[:warning]).to eq("Book not found in database!")
      end
    end
  end
  describe 'adding books' do
    context 'Required fields are filled in' do
      before :each do
        @fake_book = {"title" => "Book", "author" => "Sarah", "isbn" => "123456789", "image" => "nobook.gif"}
        @fake_book_result = double(:book=>{:title => "Book Title"})
        allow(Book).to receive(:create!).with(@fake_book).and_return(@fake_book_result)
        allow(@fake_book_result).to receive(:title).and_return('Book')
      end    
      #it 'It should call the Book create method' do
      #  expect(:current_user).to receive(create!).with(@fake_book)
      #  post :create, {:book => @fake_book}
      #end
      it 'should return to movies page' do
        post :create, {:book => @fake_book}
        expect(response).to redirect_to(mybooks_path)
      end
      it 'it should make the results available' do
        post :create, {:book => @fake_book}
        expect(assigns(:info)).to eq(@fake_book)
      end
      it 'should show flash indicating book added' do
        post :create, {:book => @fake_book}
        expect(flash[:notice]).to eq("Book was successfully added.")
      end
    end
    context 'Missing fields' do
      before :each do
        @fake_book = {"title" => "", "author" => "", "isbn" => "", "image" => "nobook.gif"}
        @fake_book_result = double(:book=>{:title => ""})
        allow(Book).to receive(:create!).with(@fake_book).and_return(@fake_book_result)
        allow(@fake_book_result).to receive(:title).and_return('')
        post :create, {:book => @fake_book}
      end
      it 'should return to movies page' do
        expect(response).to render_template('new')
      end
      it 'should show flash indicating empty fields' do
        expect(flash[:warning]).to eq("Isbn can't be blank<br/>Isbn is invalid<br/>Title can't be blank<br/>Author can't be blank")
      end
    end
    context 'Missing image' do
      before :each do
        @fake_book = {"title" => "Book", "author" => "Sarah", "isbn" => "123456789", "image" => ""}
        post :create, {:book => @fake_book}
      end
      it 'should fill in image' do
        expect(assigns(:info)[:image]).to eq('nobook.gif')
      end
    end
    context 'Hyphens or spaces in isbn' do
      it 'should remove all hypens and spaces' do
        @fake_book = {"title" => "Book", "author" => "Sarah", "isbn" => "123-456 789", "image" => ""}
        post :create, {:book => @fake_book}
        expect(assigns(:info)[:isbn]).to eq('123456789')
      end
    end
  end
  describe 'updating books' do
    context 'All fields entered' do
      before :each do
        @fake_book = {"title" => "Book Title", "author" => "Sarah", "isbn" => "123456789", "image" => "image.gif"}
        @new_book = Book.new(@fake_book)
        @new_book.save
        put :update, {:id=>@new_book.id, :book=>@fake_book}
      end
    
      it 'should flash warning' do
        expect(flash[:notice]).to eq("Book Title was successfully updated.")
      end
      it 'should redirect to book path' do
        expect(response).to redirect_to(book_path(@new_book.id))
      end
    end
    context 'Missing fields' do
      before :each do
        @fake_book = {:id=>2,"title" => "This Book", "author" => "Sarah", "isbn" => "123456789", "image" => "image.gif"}
        @fake_book_edit = {"title" => "", "author" => "Sarah", "isbn" => "123456789", "image" => "image.gif"}
        new_book = Book.new(@fake_book)
        new_book.save
        put :update, {:id=>new_book.id, :book=>@fake_book_edit}
      end
      it 'should flash warning' do
        expect(flash[:warning]).to eq("Title can't be blank")
      end
      it 'should redirect to edit book path' do
        expect(response).to redirect_to(edit_book_path)
      end
    end
  end
end

