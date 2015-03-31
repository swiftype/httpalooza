module HTTPalooza
  module Players
    class RestClientPlayer < Base
      introducing! :rest_client, %w[ rest_client ]

      def response
        response = RestClient::Request.execute(
          :method => request.method,
          :url => request.url.to_s,
          :payload => request.payload,
          :headers => request.headers
        )
        Response.new(response.code, response.to_str)
      end
    end
  end
end
