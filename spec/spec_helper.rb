require_relative '../lib/octonore'

require 'webmock/rspec'
require 'vcr'
require 'coveralls'
Coveralls.wear!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/octonore_cassettes'
  c.hook_into :webmock
end
