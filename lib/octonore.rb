require 'httparty'

Dir[File.dirname(__FILE__) + '/octonore/*.rb'].each do |file|
  require file
end
