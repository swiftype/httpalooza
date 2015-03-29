module HTTPalooza
  module Players
    class CurlPlayer < Base
      introducing! :curl

      def response
        output = `curl -isX #{request.method.to_s.upcase} '#{request.url}'`
        code = output.scan(/^HTTP[^\s]*\s(\d+)/).first.first.to_i rescue 0
        body = output.split(/^\s$/, 2).last
        Response.new(code, body)
      end
    end
  end
end
