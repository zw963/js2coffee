# js2coffee [![Build Status](https://travis-ci.org/zw963/js2coffee.svg?branch=master)](https://travis-ci.org/zw963/js2coffee) [![Gem Version](https://badge.fury.io/rb/js2coffee.svg)](http://badge.fury.io/rb/js2coffee)

Convert yours JavaScript to CoffeeScript, vice versa.

## Philosophy

* Keep it simple, a command line with no more options.
* Pretty format output with [coderay](https://github.com/rubychan/coderay).
* Watch a directory, convert automaticly when file change.
* SourceMap generation automaticly, for debug with CoffeeScript in Firefox/Chrome.
* With Nodejs, just for Ruby on Rails developer.

## Getting Started

Install via Rubygems

    $ gem install js2coffee

## Usage

Run `js2coffee` or `js2coffee` individually.

### Compile script file to STDOUT.

    $ coffee2js your_awesome.coffee

Or ...

    $ coffee2js your_awesome.coffee

You can redirect STDOUT to a new file.

    $ coffee2js your_awesome.coffee > you_awesome.js

![File](http://zw963.github.io/snapshot12.png)

### Watching one directory

    $ coffee2js script_directory

This will create corresponding js(.js) and Source Map(.js.map) in same directory as coffee file live in.
map file will keep hide with leading dot, e.g. `awesome.js` will create `awesome.coffee and .awesome.js.map`

![Monitor](http://zw963.github.io/snapshot11.png)
    
If one directory named `coffee` or named `js` in you project root, will create another directory
automaticly with cloned directory hierarchy, this will make js and coffee file saved seperately.

![Monitor](http://zw963.github.io/snapshot14.png)

### Compile script directly
You can run coffee script directly with: `-e` argments or pipe.

![File](http://zw963.github.io/snapshot15.png)
![File](http://zw963.github.io/snapshot16.png)

## Environment variable

You can setting `JS2COFFEE_EXCLUDE_PATTERN` to specify the pattern to be skipped when watching one directory.

    $ export JS2COFFEE_EXCLUDE_PATTERN='one_pattern|another_pattern'

js2coffee will always skip `node_modules` and `bower_components`.

## Support

  * MRI 1.9.3+
  * Rubinius 2.2+

## Compiler current used:

  * [CoffeeScript 1.1.0](http://coffeescript.org), used for convert from CoffeeScript to JavaScript.
  * [js2coffee 2.1.0](http://js2.coffee), used for convert JavaScript to CoffeeScript.

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
