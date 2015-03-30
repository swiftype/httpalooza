require 'net/http'
require 'net/https'

module HTTPalooza
  module Players
    class NetHTTPPlayer < Base
      introducing! :net_http

      def response
        http = Net::HTTP.new(request.url.host, request.url.inferred_port)

        if request.ssl?
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end

        net_http_request = net_http_request_class.new(request.url.request_uri)

        if [:post, :put].include?(request.method)
          net_http_request.body = request.payload
        end

        (request.headers || {}).each do |key, value|
          net_http_request.send(:[]=, key, value)
        end

        net_http_response = http.request(net_http_request)
        Response.new(net_http_response.code, net_http_response.body)
      end

      private

      def net_http_request_class
        case request.method
        when :get
          Net::HTTP::Get
        when :post
          Net::HTTP::Post
        when :put
          Net::HTTP::Put
        when :delete
          Net::HTTP::Delete
        else
          raise "Unable to process #{request.method} request method"
        end
      end
    end
  end
end
