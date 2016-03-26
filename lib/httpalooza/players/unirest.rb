module HTTPalooza
  module Players
    class UnirestPlayer < Base
      require 'unirest'
      introducing! :unirest

      def response
        response = Unirest::HttpClient.request(request.method, request.url.to_s, request.params, nil)
        Response.new(response.code, response.body)
      end
    end
  end
end
