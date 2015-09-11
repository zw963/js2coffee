#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'execjs'
require 'pathname'
require 'js2coffee/path_helper'
require 'js2coffee/compiler'

module Js2coffee
  class CoffeeCompiler < Compiler
    self.source = 'coffee-script'

    class << self
      def wrapper
        <<-WRAPPER
(function(script, options) {
    try {
        var result;
        result = CoffeeScript.compile(script, options);
        return {code: result.js, sourceMap: result.v3SourceMap};
    } catch (err) {
        if (err instanceof SyntaxError && err.location) {
            throw new SyntaxError([options.filename, err.location.first_line + 1, err.location.first_column + 1].join(":") + ": " + err.message)
        } else {
            throw err;
        }
    }
})
WRAPPER
      end

      def watch_file(file)
        file_path = Pathname(file)
        source_code = file_path.read
        target_file, target_map = Js2coffee::PathHelper.new(file_path).create_js_path!
        # generate js and SourceMap.
        result = compiler.call(wrapper, source_code, bare: false, sourceMap: true,
                               sourceFiles: [file_path.relative_path_from(target_file.dirname).to_s],
                               generatedFile: target_file.relative_path_from(target_file.dirname).to_s
                              )
        target_file.write("#{ENV['JS_SHEBANG']}#{result['code']}
//# sourceMappingURL=#{target_map.relative_path_from(target_file.dirname)}")
        target_map.write(result['sourceMap'])

        puts "[1m[32m==>[0m #{target_file}"
        target_file
      rescue ExecJS::RuntimeError
        error_msg = "[#{file_path}]: #{$!.message}"
        `notify-send "#{error_msg}" -t 5000` if system 'which notify-send &>/dev/null'
        puts error_msg
      end
    end
  end
end
