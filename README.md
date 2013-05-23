Octonore [![Build Status](https://travis-ci.org/zachlatta/octonore.png?branch=master)](https://travis-ci.org/zachlatta/octonore) [![Code Climate](https://codeclimate.com/github/zachlatta/octonore.png)](https://codeclimate.com/github/zachlatta/octonore)
========

An octolicious wrapper around the [Gitignore templates API](http://developer.github.com/v3/gitignore/).

	$ gem install octonore


Usage
-----

To get a gitignore template you first need to instantiate it.

	>> c_template = Octonore::Template.new('C')
    => #<Octonore::Template:0x007fe5f401a1d0 @name="C">

To get a hash of its name and source code, call its `data` method.

	>> c_template.data
	=> #<HTTParty::Response:0x7fe5f50adad8 parsed_response={"name"=>"C", "source"=>"# Object fi…

### Example Program

```ruby
require 'octonore'

templates = [ Octonore::Template.new('C'), Octonore::Template.new('Java') ]

templates.each do |template|
  File.open("#{template.data["name"]}.gitignore", 'w') { |file|
    file.write(template.data["source"])
  }
end
```
