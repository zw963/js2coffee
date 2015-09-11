#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module Js2coffee
  class JsCompiler < Compiler
    self.source = 'js2coffee'

    class << self
      def wrapper
        <<-WRAPPER
(function(script, options) {
    try {
        var result;
        result = window.js2coffee.build(script, options);
        return {code: result.code, sourceMap: result.map, warnings: result.warnings};
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

      def compiler
        @coffee ||= ExecJS.compile("var window = {}; #{source}")
      end

      def watch_file(file)
        file_path = Pathname(file)
        source_code = file_path.read
        target_file, target_map = Js2coffee::PathHelper.new(file_path).create_coffee_path!
        puts target_file, target_map
        # generate coffee and SourceMap.
        result = compiler.call(wrapper, source_code)
        target_file.write(result['code'])
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
