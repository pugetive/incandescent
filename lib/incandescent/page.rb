SOURCES = ['google', 'bing', 'yandex', 'baidu', 'other']

module Incandescent
  class Page
    attr_reader :page, :source, :date, :usage_image, :usage_height, :usage_width, :image, :iid

    def initialize(json_info)
      index, page_info = json_info

      @page         = page_info["page"]
      @source       = page_info["source"]
      @date         = page_info["date"]
      @usage_image  = page_info["usage-image"]
      @usage_height = page_info["usage-height"]
      @usage_width  = page_info["usage-width"]
      @image        = page_info["image"]
      @iid          = page_info["iid"]
    end
  end
end