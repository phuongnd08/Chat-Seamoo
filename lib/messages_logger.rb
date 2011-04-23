class MessagesLogger
  class << self
    def add(message)
      index = Memcached.incr({:type => :message, :field => :counter})
      Memcached[{:type => :message, :index =>  index % Settings::History.capacity}] = message.merge(:time => Time.now.to_i)
    end

    def last(count = Settings::History.capacity)
      arr = (0...Settings::History.capacity).map{ |index|
        Memcached[{:type => :message, :index =>  index}]
      }
      arr = arr.select{|msg| !msg.nil?}
      arr = arr.sort_by{|msg| msg[:time]}
      arr[-count..-1]
    end
  end
end
