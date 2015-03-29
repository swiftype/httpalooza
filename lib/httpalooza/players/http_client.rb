module HTTPalooza
  module Players
    class HTTPClientPlayer < Base
      introducing! :http_client, %w[ httpclient ]

      def response
        client = HTTPClient.new
        response = client.request(request.method, request.url, nil, request.payload, request.headers)
        Response.new(response.code, response.body)
      end
    end
  end
end
