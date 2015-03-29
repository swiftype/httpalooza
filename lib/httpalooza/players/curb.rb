module HTTPalooza
  module Players
    class CurbPlayer < Base
      introducing! :curb, %w[ curb ]

      def response
        easy = Curl::Easy.new(request.url.to_s)
        easy.headers = request.headers.to_hash
        easy.nosignal = true

        if [:post, :put].include?(request.method)
          easy.post_body = request.payload
        end

        easy.http(request.method.to_s.upcase)
        Response.new(easy.response_code, easy.body_str)
      end
    end
  end
end
