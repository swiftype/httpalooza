module HTTPalooza
  class Response
    AwesomeResponseCodes = 200..299

    attr_accessor :code, :body

    def initialize(code, body)
      @code = code.to_i
      @body = body
    end

    def awesome?
      AwesomeResponseCodes.include?(code)
    end

    def not_awesome?
      !awesome?
    end

    def inspect
      "<HTTPalooza::Response:#{object_id} code=#{code} body=#{body.to_s.inspect.truncate(30)}"
    end

    def ==(other)
      self.eql?(other)
    end

    def eql?(other)
      code == other.code && body == other.body
    end

    def hash
      body.hash ^ code.hash
    end

  end
end
