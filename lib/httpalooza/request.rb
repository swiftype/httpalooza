module HTTPalooza
  # Request presents a standard interface for describing an HTTP request that Players can translate into the underlying library's representation.
  class Request
    STANDARD_METHODS = [:get, :post, :put, :patch, :delete, :options, :head]

    attr_reader :url, :method, :params, :payload, :headers
    # @!attribute [r] url
    #    @return [String] the URL to request
    # @!attribute [r] method
    #   @return [Symbol] the HTTP method
    # @!attribute [r] params
    #   @return [Hash] the URL parameters
    # @!attribute [r] payload
    #   @return [String] the request body
    # @!attribute [r] headers
    #   @return [Hash] the request headers

    # Instantiate a Request.
    #
    # @param [String] url the URL to request
    # @param [Symbol] method the HTTP method
    # @param [Hash] options additional options
    # @option options [Hash] :params the URL parameters
    # @option options [Hash] :headers the request headers
    # @option options [String] :payload the request payload
    def initialize(url, method, options = {})
      @url = url
      @method = method
      @params = options[:params] || {}
      @payload = options[:payload]
      @headers = Rack::Utils::HeaderHash.new(options[:headers] || {})

      normalize_url!
    end

    # @return [Boolean] whether or not the URL is SSL
    def ssl?
      !!(url.to_s =~ /^https/)
    end

    STANDARD_METHODS.each do |verb|
      define_method(:"#{verb}?") do
        method == verb
      end
    end

    private
    def normalize_url!
      raise ArgumentError, "Invalid URL: #{url}" unless url.to_s =~ /^http/
      @url = url.kind_of?(Addressable::URI) ? url : Addressable::URI.parse(url)
      @url.query_values = (@url.query_values || {}).merge(params)
      @url.normalize!
    end
  end
end
