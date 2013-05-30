Octonore [![Build Status](https://travis-ci.org/zachlatta/octonore.png?branch=master)](https://travis-ci.org/zachlatta/octonore) [![Code Climate](https://codeclimate.com/github/zachlatta/octonore.png)](https://codeclimate.com/github/zachlatta/octonore) [![Coverage Status](https://coveralls.io/repos/zachlatta/octonore/badge.png?branch=master)](https://coveralls.io/r/zachlatta/octonore?branch=master) [![Dependency Status](https://gemnasium.com/zachlatta/octonore.png)](https://gemnasium.com/zachlatta/octonore)
========

An octolicious wrapper around the [Gitignore Templates API](http://developer.github.com/v3/gitignore/).

	$ gem install octonore


Usage
-----

List the available templates by calling `Template`'s list method.

    >> Octonore::Template.list
    => ["Actionscript", "Android", "AppceleratorTitanium", "Autotools", "Bancha", "
    C", "C++", "CFWheels", "CMake", "CSharp", "CakePHP", "Clojure", "CodeIgniter...

To get a gitignore template you first need to instantiate it.

	>> c_template = Octonore::Template.new('C')
    => #<Octonore::Template:0x007fe65b8b2420 @name="C", @source="# Object files\n*.
    o\n\n# Libraries\n*.lib\n*.a\n\n# Shared objects (inc. Windows DLLs)\n*.dll\n*.
    so\n*.so.*\n*.dylib\n\n# Executables\n*.exe\n*.out\n*.app\n">

To get the template's source code, you can call its `source` accessor.

	>> c_template.source
	=> "# Object files\n*.o\n\n# Libraries\n*.lib\n*.a\n\n# Shared objects (inc. Wi
    ndows DLLs)\n*.dll\n*.so\n*.so.*\n*.dylib\n\n# Executables\n*.exe\n*.out\n*.app
    \n"


You can also get the template's name with the `name` accessor.

    >> c_template.name
    => "C"

You can reload the template's source from Github with the `update` method.

    >> c_template.update
	=> "# Object files\n*.o\n\n# Libraries\n*.lib\n*.a\n\n# Shared objects (inc. Wi
    ndows DLLs)\n*.dll\n*.so\n*.so.*\n*.dylib\n\n# Executables\n*.exe\n*.out\n*.app
    \n"


### Example Program

The following program asks the user for the name of a gitignore template. It then writes the gitignore to a file ending in `.gitignore`. If the user enters `Java`, then it will write the Java gitignore template to `java.gitignore` in the current directory.

```ruby
require 'octonore'

begin
  print "Enter the name of a gitignore template (case sensitive): "
  template = Octonore::Template.new(gets.strip)
  
  File.open("#{template.name.downcase}.gitignore", 'w') { |file|
          file.write(template.source) }
rescue GitignoreTemplateNotFoundError => e
  puts e.message
end
```
