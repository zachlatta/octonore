Gem::Specification.new do |s|
  s.name        = 'octonore'
  s.version     = '0.0.2'
  s.date        = '2013-05-23'
  s.summary     = "Wrapper around the Github gitignore template API."
  s.description = "An octolicious wrapper around the Github gitignore template
                   API."
  s.license     = 'MIT'

  s.authors  = ["Zach Latta"]
  s.email    = 'zchlatta@gmail.com'
  s.homepage = 'http://rubygems.org/gems/octonore'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f|
                      File.basename(f)
                    }
  s.require_paths = ["lib"]
end
