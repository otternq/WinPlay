require 'spec_helper'

module Spot
  describe App do
    describe "GET /" do
      it "should greet us" do
        get "/"
        last_response.should be_ok
        last_response.body.should == "Welcome to WinPlay!<br/>http://github.com/otternq/WinPlay"
      end 
    end
  end
end