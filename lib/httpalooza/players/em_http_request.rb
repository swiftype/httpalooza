module HTTPalooza
  module Players
    class EmHttpRequestPlayer < Base
      introducing! :em_http_request, %w[ em-synchrony em-synchrony/em-http ]

      def response
        response = nil
        EM.synchrony do
          http_request = EventMachine::HttpRequest.new(request.url)
          http_client = http_request.send(request.method, :body => request.payload, :head => request.headers)
          response = Response.new(http_client.response_header.status, http_client.response)
          EM.stop
        end
        response
      end
    end
  end
end
