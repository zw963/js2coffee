#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'execjs'
require 'pathname'
require 'js2coffee/path_helper'

module Js2coffee
  class Compiler
    class << self
      def source
        @source or fail 'Specify compiler source first.'
      end

      def source=(new_source)
        @source = File.read(File.expand_path("../compiler/#{new_source}.js", __FILE__))
      end

      def wrapper
        fail NotImplementError, 'define wrapper in subclass!'
      end

      def compiler
        @coffee ||= ExecJS.compile(source)
      end

      def compile(script, options={})
        result = compiler.call(wrapper, script, options)
        result['code']
      rescue ExecJS::RuntimeError
        puts $!.message
      end

      def compile_file(file, options={})
        result = compiler.call(wrapper, Pathname(file).read, options)
        puts "[1m[32m==>[0m #{file}" if $stdout.tty?
        result['code']
      rescue ExecJS::RuntimeError
        puts $!.message
      end
    end
  end
end
