module Incandescent
  class Host
    attr_reader :pages
    def initialize(json_info)
      @name = json_info.shift
      @pages = []
      json_info.first["pages"].each do |page_info|
        @pages << Incandescent::Page.new(page_info)
      end
    end

  end

end