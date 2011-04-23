require 'spec_helper'

describe MessagesLogger do
  it "should return last 10 recorded messages", :memcached => true do
    now = Time.now
    (1..20).each do |index|
      Time.stub(:now).and_return(now + index)
      MessagesLogger.add({:content => "msg #{index}"})
    end
    last = MessagesLogger.last(10)
    last.size.should == 10
    (1..10).each do |index|
      last[index - 1][:content].should == "msg #{index + 10}"
    end
  end
end
