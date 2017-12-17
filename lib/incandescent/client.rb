module Incandescent

  class Client
    attr_reader :uid, :api_key, :image_urls, :project_id

    def initialize(uid, api_key)
      @uid        = uid
      @api_key    = api_key
      @image_urls = []
      @project_id = nil
    end

    def add_image_url(url)
      image_urls << url
    end

    def initiate_search
      if image_urls.empty?
        raise Incandescent::Error, "Cannot initiate search before adding images to the queue."
      end
      handle_add_response(Incandescent::ServiceCall.new(:add, images: image_urls, multiple: 3).results)
    end

    def get_results
      handle_get_response(Incandescent::ServiceCall.new(:get, project_id: project_id).results)
    end

    private

      def handle_add_response(results)
        if JSON.parse(results.body)["project_id"]
          @project_id = JSON.parse(results.body)["project_id"]
        else
          raise Incandescent::Error, "Failed to capture project_id from Incandescent API"
        end
      end

      def handle_get_response(results)
        hosts = []
        JSON.parse(results.body).each do |host_json|
          hosts << Incandescent::Host.new(host_json)
        end
        hosts
      end

  end

end