#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'js2coffee/compiler'
require 'js2coffee/watcher'
require 'js2coffee/version'

module CoffeeWithoutNodejs
  def self.compile(coffee, bare=true, create_target_jsfile=false)
    if File.file?(coffee)
      CoffeeCompiler.compile_file(coffee, bare, create_target_jsfile)
    else
      CoffeeCompiler.compile(coffee, bare)
    end
  end

  def self.watch!
    CoffeeWatcher.instance
  end

  def self.send_notify(message)
    `notify-send '#{message}' -t 1000` if system 'which notify-send &>/dev/null'
  end
end
