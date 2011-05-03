require 'spec_helper'
describe "History" do
  describe "App" do
    def app
      History::App
    end

    describe "/history" do
      describe "with count option set to 10" do
        it "should return last 10 messages" do
          now = Time.now
          (1..20).each do |index|
            Time.stub(:now).and_return(now + index)
            MessagesLogger.add("channel1", {:content => "msg #{index}"})
          end
          get "/history", :channel => "channel1", :count => 10
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
          MessagesLogger.add("channel1", {:content => "msg #{index}"})
        end
        get "/history", :channel => "channel1"
        last_response.should be_ok
        data = JSON.parse(last_response.body)
        data.length.should == 15
        data.last["content"].should == "msg 20"
      end
    end
  end

  describe "Extension" do
    describe "incoming" do
      describe "with meta message" do
        it "should not record message" do
          message = {"channel" => "/meta/wow", "data" => "abc"}
          MessagesLogger.should_not_receive(:add)
          called = false
          History::Extension.new.incoming(message, lambda{ called = true })
          called.should be_true
        end
      end
      describe "without meta message" do
        it "should assign record message and invoke callback" do
          message = {"channel" => "/leagues/1", "data" => "abc"}
          called = false
          MessagesLogger.should_receive(:add).with("/leagues/1", message["data"])
          History::Extension.new.incoming(message, lambda{ called = true })
          called.should be_true
        end
      end
    end

  end
end
