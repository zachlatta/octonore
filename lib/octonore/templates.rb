module Octonore

  class Templates

    include HTTParty

    USER_AGENT = "octonore/#{VERSION}"
    base_uri 'https://api.github.com/gitignore'

    @@instance = Templates.new

    # List all of the templates available.
    #
    # @return [Array] the available templates
    def self.list
      @@instance.get "/templates"
    end

    # Get a specified template by name.
    #
    # @param name (String) name of template to get, case sensitive
    # @return [Template] template retrieved
    def self.get_name(name)
      Template.new(name)
    end

    # Get a specified template by index.
    #
    # @param index (FixNum) index of template to get in list
    # @return [Template] template retrieved
    def self.get_index(index)
      if index > list.size
        raise GitignoreTemplateNotFoundError
      else
        name = list[index]
        get_name name
      end
    end
    

    def get(query)
      self.class.get query, headers: headers
    end


    private

    def headers
      {"User-Agent" => USER_AGENT}
    end

  end

end
