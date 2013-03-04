module LinkedIn
  module Helpers
    module Logging

      def log(&block)
        open(Rails.root.join('log', 'linkedin_job_posting.log'), 'a') do |logfile|
          consumer.http.set_debug_output logfile
          logfile.puts "\n======= job_close ======"
          yield
        end

        consumer.http.set_debug_output nil
      end

    end
  end
end
