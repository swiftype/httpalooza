module HTTPalooza
  module Players
    class SeleniumPlayer < Base
      introducing! :selenium, %w[ selenium-webdriver ]

      def response
        if request.method == :get
          get_url
        elsif request.method == :post
          post_html_form
        else
          request_ajax
        end
      ensure
        driver.quit
      end

    private

      def driver
        @driver ||= Selenium::WebDriver.for :chrome, :switches => %w[ --disable-web-security ]
      end

      def get_url
        driver.navigate.to request.url
        Response.new(200, driver.page_source)
      end

      def post_html_form
        driver.navigate.to "http://example.com"

        url = driver.current_url
        payload = CGI.parse(payload_to_params)

        driver.execute_script <<-JAVASCRIPT
          var payload = JSON.parse('#{payload.to_json}');

          var form = document.createElement('form');
          form.action = #{request.url.to_s.to_json};
          form.method = 'post';

          for (key in payload) {
            if (payload.hasOwnProperty(key)) {
              for (var i = 0; i < payload[key].length; i++) {
                var value = payload[key][i];
                var input = document.createElement('input');
                input.name = key;
                input.value = payload[key][i];
                form.appendChild(input);
              }
            }
          }

          document.body.appendChild(form);
          form.submit();
        JAVASCRIPT

        wait_until_true { driver.current_url != url }

        Response.new(200, driver.page_source)
      end

      def request_ajax
        driver.navigate.to "http://example.com"

        driver.execute_script <<-JAVASCRIPT
          var url = #{request.url.to_s.to_json};
          var method = #{request.method.upcase.to_json};
          var headers = JSON.parse('#{request.headers.to_json}');
          var payload = #{payload_to_params.to_json};

          var http = new XMLHttpRequest();
          http.open(method, url);

          for (key in headers) {
            if (headers.hasOwnProperty(key)) {
              http.setRequestHeader(key, headers[key]);
            }
          }

          http.onreadystatechange = function () {
            if (http.readyState === http.DONE) {
              window.httpalooza_response = [http.status, http.responseText];
            }
          };

          http.send(payload);
        JAVASCRIPT

        wait_until_true do
          driver.execute_script "return typeof window.httpalooza_response !== 'undefined'"
        end

        Response.new(*driver.execute_script("return window.httpalooza_response"))
      end

      def wait_until_true(timeout: 10, &block)
        Selenium::WebDriver::Wait.new(:timeout => timeout).until(&block)
      end

      def payload_to_params
        if request.payload.is_a?(Hash)
          request.payload.to_param
        elsif request.payload.is_a?(String)
          begin
            JSON.parse(request.payload).to_param
          rescue JSON::ParserError
            request.payload
          end
        else
          ""
        end
      end
    end
  end
end
