require 'spec_helper'
require 'rails_helper'

describe BooksController do
  describe 'seraching Openlibrary' do
    before :each do
      @fake_results = {:title => "Bool1"}
    end
    it 'should call the model method that performs Openlibrary search' do
      expect(Book).to receive(:open_lib_find_book).with('123456789').and_return (@fake_results)
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
end
