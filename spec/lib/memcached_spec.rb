require 'spec_helper'
describe Memcached do
  before(:each) {Memcached.client.flush_all}
  it "should get and set property properly" do
    Memcached[{:kind => "msg", :index => 0}].should == nil
    Memcached[{:kind => "msg", :index => 0}] = "abc"
    Memcached[{:kind => "msg", :index => 0}].should == "abc"
  end

  it "should incr property properly" do
    Memcached.incr({:kind => "counter"}).should == 1
    Memcached.incr({:kind => "counter"}).should == 2
    Memcached.incr({:kind => "counter"}).should == 3
  end
end
