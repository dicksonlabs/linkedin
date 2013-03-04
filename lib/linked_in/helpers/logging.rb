module LinkedIn
  module Helpers
    module Logging

      def log(&block)
        response = nil
        open(@logfile, 'a') do |logfile|
          consumer.http.set_debug_output logfile
          logfile.puts "\n======= #{caller[4][/`.*'/][1..-2]} ======="
          response = yield
        end
        consumer.http.set_debug_output nil
        response
      end

    end
  end
end
