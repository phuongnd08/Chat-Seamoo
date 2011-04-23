require 'spec_helper'
describe "History" do
  describe "App" do
    def app
      History::App
    end

    describe "/" do
      describe "with count option set to 10" do
        it "should return last 10 messages" do
          now = Time.now
          (1..20).each do |index|
            Time.stub(:now).and_return(now + index)
            MessagesLogger.add({:content => "msg #{index}"})
          end
          get "/", :count => 10
          last_response.should be_ok
          data = JSON.parse(last_response.body)
          data.length.should == 10
          data.last["content"].should == "msg 20"
        end
      end
    end

    describe "without count option" do
      it "should return all last available messages" do
        now = Time.now
        Settings::History.capacity
        Settings::History.stub(:capacity).and_return(15)
        (1..20).each do |index|
          Time.stub(:now).and_return(now + index)
          MessagesLogger.add({:content => "msg #{index}"})
        end
        get "/"
        last_response.should be_ok
        data = JSON.parse(last_response.body)
        data.length.should == 15
        data.last["content"].should == "msg 20"
      end
    end
  end

  describe "Extension" do
    describe "incoming" do
      it "should assign record message and invoke callback" do
        message = {:content => "some content"}
        called = false
        MessagesLogger.should_receive(:add).with(message)
        History::Extension.new.incoming(message, lambda{ called = true })
        called.should be_true
      end
    end

  end
end
