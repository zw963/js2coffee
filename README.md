# js2coffee [![Build Status](https://travis-ci.org/zw963/js2coffee.svg?branch=master)](https://travis-ci.org/zw963/js2coffee) [![Gem Version](https://badge.fury.io/rb/js2coffee.svg)](http://badge.fury.io/rb/js2coffee)

Convert yours JavaScript code to CoffeeScript,  vice versa.

## Philosophy

* Simple enough, just a command with no more options.
* Pretty format output with coderay.
* Watch a directory, convert automaticly when file change, smart enough to create difference
  file. (see following image.)
* SourceMap generation automaticly, you can now freely debug CoffeeScript with Firefox/Chrome.
* With Nodejs, just for Ruby on Rails development.

Just for one things, convert between CoffeeScript and JavaScript, simplely & elegantly.

- you create a new coffee files: `coffee/models/product.coffee` in your's project root.
- I will create/update new js files `js/models/product.js` and `js/models/product.map` for you.
   
## Getting Started

Install via Rubygems

    $ gem install js2coffee

Install via bundler

    gem "js2coffee"

## Usage

    $ coffee2js
    
Or ...

    $ coffee2js some_coffee_files_directory

This will create corresponding js and source map file in same directory as coffee file live in.

![Monitor](http://zw963.github.io/snapshot11.png)
    
If one directory named 'coffee' in you project root, and run `coffee2js` in project root.
will create two new `js` `.map` directory the same level as `coffee` directory,
with cloned directory hierarchy, store js and source map individually.
    
    $ ls
     coffee/
     
    $ coffee2js coffee
    
![Monitor](http://zw963.github.io/snapshot14.png)

Or ...

You always can provide one or more `some_file.coffee' file as arguments.
This will output compiled js content to STDOUT with very pretty format.

    $ coffee2js some_path/file1.coffee

![File](http://zw963.github.io/snapshot12.png)

You still can use redirect `coffee2js some_path/file1.coffee > another_path/file2.js` to
save literal js outout to file2.js

Or ...

You can run coffee script directly with: `-e` argments or pipe.

![File](http://zw963.github.io/snapshot15.png)
![File](http://zw963.github.io/snapshot16.png)

This gem is extract from [Alternative Script Suite](https://github.com/zw963/ass).
You can found a lot of useful and interesting scripts here.

## Support

  * MRI 1.9.3+
  * Rubinius 2.2+

## Compiler current used:
  * CoffeeScript 1.9.2 http://coffeescript.org, convert from CoffeeScript to JavaScript.
  * js2coffee 2.1.0 http://js2.coffee/, convert JavaScript to CoffeeScript.

## History

  More update info, please See [CHANGELOG](https://github.com/zw963/js2coffee/blob/master/CHANGELOG) for details.

## Contributing

  * [Bug reports](https://github.com/zw963/js2coffee/issues)
  * [Source](https://github.com/zw963/js2coffee)
  * Patches:
    * Fork on Github.
    * Run `gem install --dev js2coffee` or `bundle`.
    * Create your feature branch: `git checkout -b my-new-feature`.
    * Commit your changes: `git commit -am 'Add some feature'`.
    * Push to the branch: `git push origin my-new-feature`.
    * Send a pull request :D.

## license

Released under the MIT license, See [LICENSE](https://github.com/zw963/js2coffee/blob/master/LICENSE) for details.
