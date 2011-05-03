class MessagesLogger
  class << self
    def add(channel, message)
      index = Memcached.incr({:type => :message, :field => :counter, :channel => channel})
      Memcached[{:type => :message, :channel => channel, :index =>  index % Settings::History.capacity}] = message.merge(:time => Time.now.to_i)
    end

    def last(channel, count = Settings::History.capacity)
      arr = (0...Settings::History.capacity).map{ |index|
        Memcached[{:type => :message, :channel => channel, :index =>  index}]
      }
      arr = arr.select{|msg| !msg.nil?}
      arr = arr.sort_by{|msg| msg[:time]}
      count = [count, arr.size].min
      arr[-count..-1]
    end
  end
end
