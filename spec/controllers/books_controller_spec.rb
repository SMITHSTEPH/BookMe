require 'spec_helper'
require 'rails_helper'

describe BooksController do
  describe 'seraching Openlibrary' do
    before :each do
      @fake_results = {:title => "Bool1"}
    end
    it 'should call the model method that performs Openlibrary search' do
      expect(Book).to receive(:open_lib_find_book).with('123456789').and_return(@fake_results)
      post :search_open_lib, {:book=>{:isbn => '123456789'}}
    end
    describe 'after valid search' do
      before :each do
        allow(Book).to receive(:open_lib_find_book).and_return(@fake_results)
        post :search_open_lib, {:book=>{:isbn => '123456789'}}
      end
      it 'should select the Search Results template for rendering' do
        expect(response).to render_template('new')
      end
      it 'it should redirect to new page' do
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
        @fake_book = {"title" => "Book", "author" => "Sarah", "isbn" => "123456789", "seller" => nil, "image" => "nobook.gif"}
        @fake_book_result = double(:book=>{:title => "Book Title"})
        allow(Book).to receive(:create!).with(@fake_book).and_return(@fake_book_result)
        allow(@fake_book_result).to receive(:title).and_return('Book')
      end    
      it 'It should call the Book create method' do
        expect(Book).to receive(:create!).with(@fake_book)
        post :create, {:book => @fake_book}
      end
      it 'should return to movies page' do
        post :create, {:book => @fake_book}
        expect(response).to redirect_to(mybooks_path)
      end
      it 'it should make the results available' do
        post :create, {:book => @fake_book}
        expect(assigns(:book)).to eq(@fake_book_result)
      end
      it 'should show flash indicating book added' do
        post :create, {:book => @fake_book}
        expect(flash[:notice]).to eq("Book was successfully added.")
      end
    end
   # context 'Missing fields' do
   #   it 'should return to movies page' do
   #     post :add_tmdb, {:tmdb_movies => nil}
   #     expect(response).to redirect_to(movies_path)
   #   end
   #   it 'should show flash indicating no movies were added' do
   #     post :add_tmdb, {:tmdb_movies => nil}
   #     expect(flash[:warning]).to eq("No movies selected")
   #   end
   # end
  end
end
