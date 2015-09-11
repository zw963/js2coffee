#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'js2coffee/coffee_compiler'
require 'js2coffee/js_compiler'
require 'js2coffee/watcher'
require 'js2coffee/version'
require 'coderay'

module Js2coffee
  def self.compile_file(file, options={})
    output = $script_extname == 'coffee' ? CoffeeCompiler.compile_file(file, options) : JsCompiler.compile_file(file, options)
    pretty_print(output.to_s)
  end

  def self.watch_file(file)
    $script_extname == 'coffee' ? CoffeeCompiler.watch_file(file) : JsCompiler.watch_file(file)
  end

  def self.compile(coffee, options={})
    output = $script_extname == 'coffee' ? CoffeeCompiler.compile(coffee, options) : JsCompiler.compile(coffee, options)
    pretty_print(output.to_s)
  end

  def self.pretty_print(output)
    unless output.empty?
      token = CodeRay.scan(output, :js)
      print $stdout.tty? ? token.terminal : token.text
    end
  end

  def self.watch!
    Watcher.instance
  end

  def self.send_notify(message)
    `notify-send '#{message}' -t 1000` if system 'which notify-send &>/dev/null'
  end
end
