module HTTPalooza
  module Players
    class TyphoeusPlayer < Base
      introducing! :typhoeus, %w[ typhoeus ]

      def response
        response = Typhoeus.send(request.method, request.url, :body => request.payload)
        Response.new(response.response_code, response.body)
      end
    end
  end
end
