require 'spec_helper'
require 'rails_helper'


describe Book do
  describe 'searching OpenLibrary by isbn' do
    context 'with found isbn' do
      before :each do
        @fake_book = double('data')
        allow(@fake_book).to receive(:title).and_return('Book Title')
        allow(@fake_book).to receive(:authors).and_return(["name" => "Sarah"])
        allow(@fake_book).to receive(:thumbnail_url).and_return('image.gif')
        allow(Openlibrary::View).to receive(:find_by_isbn).with('123456789').and_return(@fake_book)
        allow(Openlibrary::Data).to receive(:find_by_isbn).with('123456789').and_return(@fake_book)
      end
      it 'should call Openlibrary::View with isbn' do
        expect(Openlibrary::View).to receive(:find_by_isbn).with('123456789')
        Book.open_lib_find_book('123456789')
      end
      it 'should call Openlibrary::Data with isbn' do
        expect(Openlibrary::Data).to receive(:find_by_isbn).with('123456789')
        Book.open_lib_find_book('123456789')
      end
      it 'it should assign values to book has' do
        result = Book.open_lib_find_book('123456789')
        expect(result).to eq({title:'Book Title', author:"Sarah", isbn:"123456789", image:'image.gif', price:"", quality:""}) 
      end
    end
    context 'isbn not found' do
      before :each do
        @fake_book = double('data')
        allow(Openlibrary::Data).to receive(:find_by_isbn).with('')
      end
      it 'it should assign empty hash to book' do
        result = Book.open_lib_find_book('')
        expect(result).to eq({}) 
      end
    end
    context 'no image found' do
      before :each do
        @fake_book = double('data')
        allow(@fake_book).to receive(:title).and_return('Book Title')
        allow(@fake_book).to receive(:authors).and_return(["name" => "Sarah"])
        allow(@fake_book).to receive(:thumbnail_url).and_return(nil)
        allow(Openlibrary::View).to receive(:find_by_isbn).with('123456789').and_return(@fake_book)
        allow(Openlibrary::Data).to receive(:find_by_isbn).with('123456789').and_return(@fake_book)
      end
      it 'should assign template image if no image is entered' do
        result = Book.open_lib_find_book('123456789')
        expect(result).to eq({title:'Book Title', author:"Sarah", isbn:"123456789", image:'nobook.gif', price:"", quality:""}) 
      
      end
    end
  end
end
