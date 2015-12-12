require 'spec_helper'
require 'rails_helper'
describe SessionsController do
  before :each do
    @user=User.new({first_name:'Foo', last_name:'Bar',password:'foobar100', password_confirmation:'foobar100', user_id:'foobar', email:'foobar@uiowa.edu'})
    @user.save
    cookies.permanent[:session_token] = User.find_by_email('foobar@uiowa.edu').session_token
  end
  describe 'logging in to an account' do 
    context 'corrrect email/password' do
      before :each do 
        post :create, {:session => {email:"foobar@uiowa.edu", password:"foobar100"}}
      end
      it 'should redirect to books path' do
        expect(response).to redirect_to(books_path)
      end
    end
    context 'incorrrect email/password' do
      before :each do 
        post :create, {:session => {email:"foobar@uiowa.edu", password:"wrongpassword"}}
      end
      it 'should render new path' do
        expect(response).to render_template('new')
      end
    end
  end    
  describe 'logout of account' do
    context 'logged in' do  
      before :each do 
        #@fake_user = {"email" => "foobar@uiowa.edu", "password" => "foobar100"}        
        delete :destroy, {:id=>1}
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

  
