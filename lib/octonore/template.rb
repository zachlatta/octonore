module Octonore

  class Template

    attr_accessor :name

    include HTTParty

    USER_AGENT = "octocore/#{VERSION}"

    base_uri 'https://api.github.com/gitignore'

    def initialize(name)
      self.name = name
    end

    def data(force = false)
      force ? @data = get_data : @data ||= get_data
    end

    def headers
      {"User-Agent" => USER_AGENT}
    end

    private

    def get_data
      self.class.get "/templates/#{self.name}", headers: headers 
    end

  end

end
