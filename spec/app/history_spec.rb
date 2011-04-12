require 'spec_helper'
describe "History App" do
  def app
    History::App
  end

  describe "/" do
    it "should return last 10 messages" do
      get "/"
      last_response.should be_ok
      data = JSON.parse(last_response.body)
      data.length.should == 10
    end
  end
end
