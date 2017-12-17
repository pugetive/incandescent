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
        raise Incandescent::Error, "Cannot initiate search before addin images to the queue."
      end
      handle_add_response(Incandescent::ServiceCall.new(:add, images: image_urls, multiple: 3).results)
    end

    def get_results
      Incandescent::ServiceCall.new(:get, project_id: project_id).results
    end

    private

      def handle_add_response(results)
        if JSON.parse(results.body)["project_id"]
          @project_id = JSON.parse(results.body)["project_id"]
        else
          raise Incandescent::Error, "Failed to capture project_id from Incandescent API"
        end
      end

  end

end