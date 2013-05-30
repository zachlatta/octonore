module Octonore

  # A gitignore template. Templates have two attributes: a
  # name and a source.
  class Template

    attr_accessor :name, :source

    # List available templates
    #
    # Example:
    #   >> Octonore::Template.list
    #
    # @return [Array] The available gitignore templates.
    def self.list
      raw_list = Octonore::HTTPHelper.instance.get("/templates")
      parsed_list = raw_list.parsed_response
    end

    # Create a new template.
    #
    # Example:
    #   c_template = Octonore::Template.new('C')
    #   java_template = Octonore::Template.new('java')
    #
    # @param name [String] name of template to create
    # @return [String] Contents of template.
    def initialize(name)
      # Get two arrays of all of the names of templates available. Downcase
      # one.
      list = self.class.list
      down_list = list.map(&:downcase)
      # Create a hash from the lowercase names to the normal names so we can
      # make the user-specified name case-insensitive.
      list_hash = Hash[down_list.zip(list)]

      # Downcase the the user's name selection and get the matching normal
      # name in the list_hash
      self.name = list_hash[name.downcase]
      # Retrieve the information from Github for their template
      reload
    end

    # Reload the Gitignore source from Github.
    #
    # Example:
    #   >> outdated_template.source = nil
    #   => nil
    #   >> outdated_template.reload
    #   => "# Object files\n*.o\n\n# Libraries\n*.lib..."
    #   >> outdated_template.source
    #   => "# Object files\n*.o\n\n# Libraries\n*.lib..."
    #
    # @return [String] Contents of template.
    def reload
      data = get_template_hash @name
      
      if valid_template_hash? data
        @source = data["source"]
      else
        raise GitignoreTemplateNotFoundError,
          "Template '#{@name}' does not exist!"
      end
    end


    protected

    # Verify that the template doesn't contain "Not Found"
    #
    # @param [Hash] The template's hash.
    # @return [Boolean] Whether the template doesn't contain "Not Found"
    def valid_template_hash?(template_hash)
      template_hash["message"] != "Not Found"
    end


    private

    # Get the specified template's hash from Github.
    # 
    # @param name [String] name of template to get
    # @return [Hash] hash containing template info
    def get_template_hash(name)
      Octonore::HTTPHelper.instance.get("/templates/#{name}")
    end

  end

end
