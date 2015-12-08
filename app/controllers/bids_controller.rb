class BidsController < ApplicationController
    
    def edit
        redirect_to :back
    end
    
    def destroy
=begin
        @ = Book.find(params[:id])
        Tag.delete_all book_id: @book.id
        @book.destroy
        flash[:notice] = "'#{@book.title}' deleted."
        redirect_to mybooks_path
=end
        redirect_to :back
    end
end