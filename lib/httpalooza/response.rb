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

    def as_key
      "code=#{@code} body=#{@body}"
    end
  end
end
