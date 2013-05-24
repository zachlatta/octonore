module Octonore

  # A gitignore template. Templates consist of a name and source.
  class Template

    attr_accessor :name, :source

    include HTTParty

    USER_AGENT = "octocore/#{VERSION}"

    base_uri 'https://api.github.com/gitignore'

    # Create a new template.
    #
    # Example:
    #   c_template = Octonore::Template.new('C')
    #   java_template = Octonore::Template.new('Java')
    #
    # Arguments:
    #   name: (String)
    
    def initialize(name)
      self.name = name
      update
    end

    # Update the Gitignore source from Github.

    def update
      data = get_data
      
      if valid_template_hash? data
        @source = data["source"]
      else
        raise GitignoreTemplateNotFoundError,
          "Template '#{@name}' does not exist!"
      end
    end


    private

    def get_data
      self.class.get "/templates/#{self.name}", headers: headers 
    end

    def valid_template_hash?(template_hash)
      template_hash["message"] != "Not Found"
    end

    def headers
      {"User-Agent" => USER_AGENT}
    end

  end

  class GitignoreTemplateNotFoundError < StandardError
  end

end
