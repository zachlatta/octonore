module Octonore

  # A gitignore template. Templates have two attributes: a
  # name and a source.
  class Template

    attr_accessor :name, :source

    # Create a new template.
    #
    # Example:
    #   c_template = Octonore::Template.new('C')
    #   java_template = Octonore::Template.new('Java')
    #
    # @param name [String] name of template to create,
    #                      case sensitive
    def initialize(name)
      self.name = name
      update
    end

    # Update the Gitignore source from Github.
    #
    # Example:
    #   >> outdated_template.source = nil
    #   => nil
    #   >> outdated_template.update
    #   => "# Object files\n*.o\n\n# Libraries\n*.lib..."
    #   >> outdated_template.source
    #   => "# Object files\n*.o\n\n# Libraries\n*.lib..."
    def update
      data = get_template_hash @name
      
      if valid_template_hash? data
        @source = data["source"]
      else
        raise GitignoreTemplateNotFoundError,
          "Template '#{@name}' does not exist!"
      end
    end

    # List available templates
    #
    # Example:
    #   >> Octonore::Template.list
    def self.list
      Octonore::HTTPHelper.instance.get("/templates")
    end


    private

    # Get the specified template's hash from Github.
    # @param name [String] name of template to get
    # @return [Hash] hash containing template info
    def get_template_hash(name)
      Octonore::HTTPHelper.instance.get("/templates/#{name}")
    end

    def valid_template_hash?(template_hash)
      template_hash["message"] != "Not Found"
    end

  end

  class GitignoreTemplateNotFoundError < StandardError
  end

end
