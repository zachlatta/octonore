require 'singleton'

module Octonore

  class HTTPHelper
    include Singleton
    include HTTParty

    USER_AGENT = "octonore/#{VERSION}"

    base_uri 'https://api.github.com/gitignore'

    # Get the specified template's hash from Github.
    # @param location [String] location of resource to get
    # @return [Hash] whatever is gotten
    def get(location)
      self.class.get location, headers: headers 
    end

    def headers
      {"User-Agent" => USER_AGENT}
    end
    
  end

end
