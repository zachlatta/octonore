lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octonore/version'

Gem::Specification.new do |s|
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_dependency 'httparty', '~> 0.11.0'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f|
                      File.basename(f)
                  }
  s.require_paths = ['lib']

  s.authors  = ['Zach Latta']
  s.email    = 'zchlatta@gmail.com'
  s.homepage = 'http://rubygems.org/gems/octonore'

  s.name        = 'octonore'
  s.version     = Octonore::VERSION
  s.date        = '2013-05-30'
  s.summary     = 'An octolicious wrapper around the Github gitignore template
                   API.'
  s.description = s.summary
  s.license     = 'MIT'
end
