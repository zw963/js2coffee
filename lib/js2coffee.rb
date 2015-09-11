#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'js2coffee/coffee_compiler'
require 'js2coffee/js_compiler'
require 'js2coffee/watcher'
require 'js2coffee/version'

module Js2coffee
  def self.compile_file(coffee, bare=true, daemon=false)
    output = if $reverse
               CoffeeCompiler.compile_file(coffee, bare, daemon)
             else
               JsCompiler.compile_file(coffee, daemon)
             end
    pretty_print(output.to_s) unless daemon
  end

  def self.compile(coffee, bare=true)
    output = if $reverse
               CoffeeCompiler.compile(coffee, bare)
             else
               JsCompiler.compile(coffee)
             end
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
