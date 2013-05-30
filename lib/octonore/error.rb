module Octonore
  
  # Raised when Github returns JSON containing "Not Found" when requesting
  # a Gitignore template.
  class GitignoreTemplateNotFoundError < StandardError; end

end
