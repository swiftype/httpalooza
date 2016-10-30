module HTTPalooza
  module Players
    class OraclePLSQLPlayer < Base
      introducing! :oracle_pl_sql, %w[oci8]

      def initialize(request)
       conn.exec(%{
        CREATE OR REPLACE FUNCTION httpalooza_http_request (http_method VARCHAR2, url VARCHAR2, body VARCHAR2)
          RETURN CLOB
        IS
          request UTL_HTTP.REQ;
          response UTL_HTTP.RESP;
          buff VARCHAR2(4000);
          pcs UTL_HTTP.html_pieces;
          ret_val CLOB;
        BEGIN
          UTL_HTTP.SET_RESPONSE_ERROR_CHECK(FALSE);

          IF http_method = 'GET' THEN
            request := UTL_HTTP.BEGIN_REQUEST(url, http_method);
          ELSIF (http_method = 'POST' OR http_method = 'PUT' OR http_method = 'DELETE') THEN
            request := UTL_HTTP.BEGIN_REQUEST(url, http_method, ' HTTP/1.1');
          END IF;

          UTL_HTTP.SET_HEADER(request, 'User-Agent', 'Mozilla/4.0');

          IF (http_method = 'POST' OR http_method = 'PUT' OR http_method = 'DELETE') THEN
            UTL_HTTP.SET_HEADER(request, 'Content-Type', 'application/json');
            UTL_HTTP.SET_HEADER(request, 'Content-Length', length(body));
            UTL_HTTP.WRITE_TEXT(request, body);
          END IF;

          response := UTL_HTTP.GET_RESPONSE(request);

          ret_val := EMPTY_CLOB;
          -- HACK! putting response code as the first part of return, it's much easier to return one blob from a plsql procedure
          ret_val := ret_val || TO_CHAR(response.status_code);

          IF response.status_code = 200 THEN
            BEGIN
              LOOP
                UTL_HTTP.READ_TEXT(response, buff, LENGTH(buff));
                ret_val := ret_val || buff;
              END LOOP;
            EXCEPTION
              WHEN UTL_HTTP.END_OF_BODY THEN
                NULL;
              WHEN OTHERS THEN
                ret_val := ret_val || SQLCODE || ' ' || SUBSTR(SQLERRM, 1, 200) || ' ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            END;
            UTL_HTTP.END_RESPONSE(response);
          END IF;

          RETURN ret_val;
        END;})

        super(request)
      end

      def response
        if request.headers.size > 1 || request.headers.size == 1 && (!request.headers.key?('Content-Type') or request.headers['Content-Type'] != 'application/json')
          raise("Oracle Procedural Language / Structured Query Language adapter doesn't currently support headers other than application/json")
        end

        case request.method
          when :get
            endpoint = request.url
            unless request.payload.nil?
              endpoint += "?#{payload_to_params}"
            end
            conn.exec("SELECT httpalooza_http_request ('GET', '#{endpoint}', '') FROM DUAL") do |results|
              return convert_database_response(results)
            end

          when :post, :put, :delete
            conn.exec("SELECT httpalooza_http_request ('#{request.method.to_s.upcase}', '#{request.url}', '#{payload_to_params}') FROM DUAL") do |results|
              return convert_database_response(results)
            end

        end
      end

      private

      def convert_database_response(results)
        result = results.first.read
        status, body = Integer(result[0..2]), result[3..-1]

        return Response.new(status, body)
      end

      def payload_to_params
        if request.payload.is_a?(Hash)
          if request.method == :get
            request.payload.to_query
          else
            request.payload.to_json
          end
        elsif request.payload.is_a?(String)
          request.payload
        else
          ''
        end
      end

      def conn
        @conn ||= begin
          OCI8.new('system', 'oracle', 'localhost')
        end
      end

    end
  end
end
