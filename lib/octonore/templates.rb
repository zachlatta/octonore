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

    # Get the templates specified by name in an array.
    #
    # @param array (Array) array of strings containing the names of the
    #                      templates to retrieve
    # @return array (Array) array of fetched templates
    def self.get_array(array)
      fetched = Array.new
      array.each do |name|
        template = Template.new(name)
        fetched.push(template)
      end

      fetched
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
