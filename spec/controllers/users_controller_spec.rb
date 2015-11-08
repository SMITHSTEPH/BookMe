require 'spec_helper'
require 'rails_helper'

describe UsersController do
  describe 'creating account' do
    context 'Required fields are filled in' do
      before :each do
        @fake_user = {"first_name" => "Blake", "last_name" => "Dunham", "user_id" => "dnham", "email" => "b@b.com", "password" => "password", "password_confirmation" => "password"}
      end
      
      it 'It should call the User create method' do
        post :create, {:user => @fake_user}
      end
      
      it 'should redirect to the login page' do
        post :create, {:user => @fake_user}
        expect(response).to redirect_to(login_path)
      end
      
      it 'should show a flash indicating the user was added' do
        post :create, {:user => @fake_user}
        expect(flash[:notice]).to eq("Welcome dnham. Your account has been created.")
      end
    end
    
    context 'Missing fields' do
      before :each do
        @fake_user = {"first_name" => "", "last_name" => "", "user_id" => "", "email" => "", "password" => "", "password_confirmation" => ""}
        allow(User).to receive(:create!).with(@fake_user)
      end
      
      it 'should return to make account page' do 
        post :create, {:user => @fake_user}
        expect(response).to render_template('new')
      end
    end
  end
end
