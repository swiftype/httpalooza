require 'open3'
require 'uri'

module HTTPalooza
  module Players
    class TelnetPlayer < Base
      introducing! :telnet

      def response
        uri = URI::parse(request.url)

        raise "Unsupported scheme: #{uri.scheme}" unless uri.scheme.to_s.upcase == 'HTTP'

        Open3.popen3('telnet', uri.host, uri.port.to_s) do |stdin, stdout, stderr, wait_thr|
          begin
            while !stdout.readline.start_with?('Escape character is'); end

            stdin.write(request_text(uri))
            stdin.flush

            code = stdout.readline.match(/HTTP\S* (\d+)/)[1].to_i
            while !stdout.readline.strip.empty?; end
            body = stdout.read

            Response.new(code, body)
          rescue
            Process.kill("TERM", wait_thr.pid) rescue Errno::ESRCH
            raise
          end
        end
      end

      private

      def request_text(uri)
        lines = []

        path_and_query = uri.path + (uri.query.present? ? "?#{uri.query}" : '')

        lines << "#{request.method.upcase} #{path_and_query} HTTP/1.1"
        lines << "Host: #{uri.host}"
        lines << 'Connection: close'
        lines << "Content-Length: #{request.payload.bytesize}" if request.payload

        (request.headers || {}).each do |key, value|
          lines << "#{key}: #{value}"
        end

        lines << ''

        if request.payload
          lines << request.payload.to_s
          lines << ''
        end

        lines << ''

        lines.join("\n")
      end
    end
  end
end
