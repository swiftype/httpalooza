module HTTPalooza
  # Response represents a unified interface for the various Player's responses.
  class Response
    AwesomeResponseCodes = 200..299

    # @!attribute code
    #   @return [Fixnum] the HTTP status code
    # @!attribute body
    #   @return [String] the HTTP response body
    attr_accessor :code, :body

    # Create a new Response.
    #
    # @param [Fixnum] code the HTTP status code. Should be between 100 and 599.
    # @param [String] body the HTTP response body.
    def initialize(code, body)
      @code = code.to_i
      @body = body
    end

    # @return [Boolean] whether or not the response code was awesome.
    def awesome?
      AwesomeResponseCodes.include?(code)
    end

    # @return [Boolean] whether or not the response code was not awesome.
    def not_awesome?
      !awesome?
    end

    def inspect
      "<HTTPalooza::Response:#{object_id} code=#{code} body=#{body.to_s.inspect.truncate(30)}"
    end

    def eql?(other)
      self.class == other.class && code == other.code && body == other.body
    end

    alias_method :==, :eql?

    def hash
      body.hash ^ code.hash
    end

  end
end
