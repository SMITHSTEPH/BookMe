require 'spec_helper'
require 'rails_helper'


describe Book do
  describe 'searching OpenLibrary by isbn' do
    before :each do
      @fake_book = double('book')
      allow(@fake_book).to receive(:title).and_return('Book Title')
      allow(@fake_book).to receive(:authors).and_return(["name" => "Sarah"])
      allow(@fake_book).to receive(:thumbnail_url).and_return('image.gif')
    end
    context 'with found isbn' do
      it 'should call Openlibrary::View with isbn' do
        allow(Openlibrary::View).to receive(:find_by_isbn).with('123456789').and_return([@fake_book])
        expect(Openlibrary::View).to receive(:find_by_isbn).with('123456789')
        Book.open_lib_find_by_isbn('123456789')
      end
      it 'should call Openlibrary::Data with isbn' do
        allow(Openlibrary::Data).to receive(:find_by_isbn).with('123456789').and_return([@fake_book])
        expect(Openlibrary::Data).to receive(:find_by_isbn).with('123456789')
        Book.open_lib_find_by_isbn('123456789')
      end
    end
    context 'isbn not found' do
    end
  end
end
