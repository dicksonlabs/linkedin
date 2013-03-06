module LinkedIn
  module Api

    module UpdateMethods

      # job posting api methods ('job' is a hash.)

      def job_post(job_xml)
        path = "/jobs"
        log do
          post(path, job_xml, {'Content-Type' => 'text/xml', 'x-li-format' => 'xml'})
        end
      end

      def job_close(job_id)
        path = "/jobs/partner-job-id=#{job_id}"
        log do
          delete(path, {'Content-Type' => 'text/xml', 'x-li-format' => 'xml'})
        end
      end

      def job_renew(job_id, job_renew_xml)
        path = "/jobs/partner-job-id=#{job_id}"
        log do
          put(path, job_renew_xml, {'Content-Type' => 'text/xml', 'x-li-format' => 'xml'})
        end
      end

      def job_edit(job_id, job_edit_xml)
        path = "/jobs/partner-job-id=#{job_id}"
        log do
          put(path, job_edit_xml, {'Content-Type' => 'text/xml', 'x-li-format' => 'xml'})
        end
      end

      # end job methods

      def add_share(share)
        path = "/people/~/shares"
        defaults = {:visibility => {:code => "anyone"}}
        post(path, defaults.merge(share).to_json, "Content-Type" => "application/json")
      end

      def join_group(group_id)
        path = "/people/~/group-memberships/#{group_id}"
        body = {'membership-state' => {'code' => 'member' }}
        put(path, body.to_json, "Content-Type" => "application/json")
      end

      # def share(options={})
      #   path = "/people/~/shares"
      #   defaults = { :visability => 'anyone' }
      #   post(path, share_to_xml(defaults.merge(options)))
      # end
      #
      def update_comment(network_key, comment)
        path = "/people/~/network/updates/key=#{network_key}/update-comments"
        body = {'comment' => comment}
        post(path, body.to_json, "Content-Type" => "application/json")
      end
      #
      # def update_network(message)
      #   path = "/people/~/person-activities"
      #   post(path, network_update_to_xml(message))
      # end
      #

      def like_share(network_key)
        path = "/people/~/network/updates/key=#{network_key}/is-liked"
        put(path, 'true', "Content-Type" => "application/json")
      end

      def unlike_share(network_key)
        path = "/people/~/network/updates/key=#{network_key}/is-liked"
        put(path, 'false', "Content-Type" => "application/json")
      end

      def send_message(subject, body, recipient_paths)
        path = "/people/~/mailbox"

        message = {
            'subject' => subject,
            'body' => body,
            'recipients' => {
                'values' => recipient_paths.map do |profile_path|
                  { 'person' => { '_path' => "/people/#{profile_path}" } }
                end
            }
        }
        post(path, message.to_json, "Content-Type" => "application/json")
      end
      #
      # def clear_status
      #   path = "/people/~/current-status"
      #   delete(path).code
      # end
      #

    end

  end
end
