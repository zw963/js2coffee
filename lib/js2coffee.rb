#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'js2coffee/coffee2js_compiler'
require 'js2coffee/watcher'
require 'js2coffee/version'

module Js2coffee
  def self.compile(coffee, bare=true, create_target_jsfile=false)
    if $reverse
      if File.file?(coffee)
        Coffee2jsCompiler.compile_file(coffee, bare, create_target_jsfile)
      else
        CoffeeCompiler.compile(coffee, bare)
      end
    else
      if File.file?(coffee)
        Js2CoffeeCompiler.compile_file(coffee, bare, create_target_jsfile)
      else
        Js2coffeeCompiler.compile(coffee, bare)
      end
    end
  end

  def self.watch!
    CoffeeWatcher.instance
  end

  def self.send_notify(message)
    `notify-send '#{message}' -t 1000` if system 'which notify-send &>/dev/null'
  end
end
