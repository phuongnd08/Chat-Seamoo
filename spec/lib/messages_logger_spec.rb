require 'spec_helper'

describe MessagesLogger, :memcached => true do
  before(:each) do
    now = Time.now
    (1..20).each do |index|
      Time.stub(:now).and_return(now + index)
      MessagesLogger.add("channel1", {:content => "msg1 #{index}"})
    end
    (1..20).each do |index|
      Time.stub(:now).and_return(now + index)
      MessagesLogger.add("channel2", {:content => "msg2 #{index}"})
    end
  end

  it "should return result according to channel" do
    last = MessagesLogger.last("channel1", 10)
    last.size.should == 10
    (1..10).each do |index|
      last[index -1][:content].should == "msg1 #{index + 10}"
    end

    last = MessagesLogger.last("channel2", 10)
    last.size.should == 10
    (1..10).each do |index|
      last[index -1][:content].should == "msg2 #{index + 10}"
    end
  end

  it "should return maximum number of available items incase the requested number is > 50" do
    last = MessagesLogger.last("channel2", 100)
    last.size.should == 20
    (1..20).each do |index|
      last[index -1][:content].should == "msg2 #{index}"
    end
  end
end
