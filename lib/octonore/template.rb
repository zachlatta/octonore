module Octonore

  # A gitignore template. Templates consist of a name and source.
  class Template

    attr_accessor :name

    include HTTParty

    USER_AGENT = "octocore/#{VERSION}"

    base_uri 'https://api.github.com/gitignore'

    # Create a new template!
    #
    # Example:
    #   c_template = Octonore::Template.new('C')
    #   java_template = Octonore::Template.new('Java')
    #
    # Arguments:
    #   name: (String)
    
    def initialize(name)
      self.name = name
    end

    # Get a Hash of the template's name and source.
    #
    # Example:
    #   >> c_template.data["name"]
    #   => C
    #
    #   >> c_template.data["source"]
    #   => # Object files\n*.o\n\n# Libraries\n*.lib\n*.a\n\n# Shared objects
    #      (inc. Windows DLLs)\n*.dll\n*.so\n*.so.*\n*.dylib\n\n# Executables\n
    #      *.exe\n*.out\n*.app\n

    def data(force = false)
      force ? @data = get_data : @data ||= get_data
    end


    private

    def get_data
      self.class.get "/templates/#{self.name}", headers: headers 
    end

    def headers
      {"User-Agent" => USER_AGENT}
    end

  end

end
