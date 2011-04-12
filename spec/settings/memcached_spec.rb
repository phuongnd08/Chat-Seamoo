require 'spec_helper'
describe Settings::Memcached do
  it "should return value according to yml file" do
    Settings::Memcached.server.should == "localhost:11211"
  end
end
