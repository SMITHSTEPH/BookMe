require 'rails_helper'
  describe ApplicationHelper, type: :helper do
   it "generates sortable links" do
       helper.stub(:params).and_return({controller: 'books', action: 'index'})
       helper.Sortable("title") #just testing out, w/o any assertions... this fails
   end
  end