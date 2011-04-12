class Memcached
  class << self
    def client
      @@client ||= Dalli::Client.new(Settings::Memcached.server, self.options)
    end


    def [](hash)
      client.get(hash_to_key(hash)) 
    end

    def []=(hash, value)
      client.set(hash_to_key(hash), value) 
    end

    def incr(hash, delta=1, default=1)
      client.incr(hash_to_key(hash), delta, 0, default)
    end

    protected
    def options
      opts = { :namespace => Settings::Memcached.nspace }
      opts.merge!(:username => Settings::Memcached.username) if Settings::Memcached["username"]
      opts
    end

    def hash_to_key(hash)
      h = hash.stringify_keys
      h.keys.sort.map{|key| [key, h[key]].join("@")}.join("_")
    end
  end
end
