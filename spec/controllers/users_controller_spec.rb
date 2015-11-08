require 'spec_helper'
require 'rails_helper'

describe UserController do
  describe 'creating account' do
    context 'Required fields are filled in' do
      before :each do
        @fake_user = {"first_name" => "Blake", "last_name" => "Dunham", "user_id" => "dnham", "email" => "b@b.com", "password" => "password", "condirmPassword" => "password"}
      end
    end
  end
end
