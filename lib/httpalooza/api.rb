module HTTPalooza
  module API
    # Peform an HTTP GET request with the assembled Lineup.
    #
    # @param [String] url the URL to request.
    # options [Hash] the request options
    # @option options [Hash] :headers request headers
    # @option options [Hash] :params URL parameters
    # @option options [String] :payload the request body
    def get(url, options = {}, &block)
      run! Request.new(url, :get, options.slice(:headers, :params, :payload), &block)
    end

    # Peform an HTTP POST request with the assembled Lineup.
    #
    # @param [String] url the URL to request.
    # options [Hash] the request options
    # @option options [Hash] :headers request headers
    # @option options [Hash] :params URL parameters
    # @option options [String] :payload the request body
    def post(url, options = {}, &block)
      run! Request.new(url, :post, options.slice(:headers, :params, :payload), &block)
    end

    # Peform an HTTP PUT request with the assembled Lineup.
    #
    # @param [String] url the URL to request.
    # options [Hash] the request options
    # @option options [Hash] :headers request headers
    # @option options [Hash] :params URL parameters
    # @option options [String] :payload the request body
    def put(url, options = {}, &block)
      run! Request.new(url, :put, options.slice(:headers, :params, :payload), &block)
    end

    # Peform an HTTP DELETE request with the assembled Lineup.
    #
    # @param [String] url the URL to request.
    # options [Hash] the request options
    # @option options [Hash] :headers request headers
    # @option options [Hash] :params URL parameters
    # @option options [String] :payload the request body
    def delete(url, options = {}, &block)
      run! Request.new(url, :delete, options.slice(:headers, :params, :payload), &block)
    end

    # Peform an HTTP HEAD request with the assembled Lineup.
    #
    # @param [String] url the URL to request.
    # options [Hash] the request options
    # @option options [Hash] :headers request headers
    # @option options [Hash] :params URL parameters
    # @option options [String] :payload the request body
    def head(url, options = {}, &block)
      run! Request.new(url, :head, options.slice(:headers, :params, :payload), &block)
    end
  end
end
