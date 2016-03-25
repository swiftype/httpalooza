module HTTPalooza
  module Players
    class HTTPartyPlayer < Base
      introducing! :httparty, %w[ httparty ]

      def response
        response = HTTParty.send(request.method, request.url, :body => request.payload)

        Response.new(response.response_code, response.body)
      end
    end
  end
end
