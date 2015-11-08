require 'spec_helper'
require 'rails_helper'
describe SessionsController do
  before :each do
    @user=User.new({first_name:'Foo', last_name:'Bar',password:'foobar100', password_confirmation:'foobar100', user_id:'foobar', email:'foobar@uiowa.edu'})
    @user.save
    cookies.permanent[:session_token] = User.find_by_email('foobar@uiowa.edu').session_token
  end
  describe 'logging in to an account' do 
    context 'Required fields are filled in' do
      before :each do 
        #@fake_user = {"email" => "foobar@uiowa.edu", "password" => "foobar100"}        
        #post :create, {:user => @fake_user}
      end
      it 'should redirect to books path' do
        #expect(response).to redirect_to(books_path)
      end
    end
    
    context 'Missing fields' do
      before :each do 
       # @fake_user = {"email" => "", "password" => "foobar100"}
       # post :create, {:user => @fake_user}
      end
      
      it 'should show a flash indicating that the email or password was not correct' do
        #expect(flash[:notice]).to eq("Invalid email/password combination")
      end
    end
  end
  describe 'logout of account' do
    context 'logged in' do  
      before :each do 
        #@fake_user = {"email" => "foobar@uiowa.edu", "password" => "foobar100"}        
        #post :create, {:user => @fake_user}
      end
      
      it 'should show a flash showing you logged out' do
        #delete :destory
        #expect(flash[:notice]).to eq("You have logged out")
      end
      
      it 'should redirect to the login page' do 
        #expect(response).to redirect_to(books_path)
      end
    end
  end
end

  