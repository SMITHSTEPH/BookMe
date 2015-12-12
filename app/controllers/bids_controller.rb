class BidsController < ApplicationController
    
  
    
    def destroy
        @bid = Bid.find(params[:id])
        book_id = @bid.book_id
        #puts "BOOOOOOOKKKKK IIDDDDDD ISSS ------------------------"
        #puts @bid.book_id
        @bid.destroy
        @book=Book.find(book_id)
        if(@bid.status!='sold')
            if(Bid.exists?(:book_id => book_id))
                Bid.order("bid asc").to_sql
                new_highest=Bid.find_by_book_id(book_id)
                new_highest.update_attribute(:status, "highest bid")
                new_highest.update_attribute(:notification, true)
            else
                @book.update_attribute(:bid_price, @book.auction_start_price) #if no one else has placed a bid
            end
            flash[:notice] = "'#{@book.title}' removed from bid"
        end
        
        flash[:notice] = "'#{@book.title}' removed from purchases"
        redirect_to :back
    end
end