#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rb-inotify'
require 'singleton'

module Js2coffee
  class Watcher
    include Singleton

    def initialize
      @notifier = INotify::Notifier.new

      Signal.trap(2) {|_sig| Process.exit }

      start_watch_files

      @notifier.watch('.', :moved_from, :moved_to, :create, :delete, :onlydir, :recursive) do |event|
        # skip temp file.
        next if event.name =~ /^\.#|^#.*\#$/

        start_watch_files
      end

      watched_files.each do |file|
        Js2coffee.compile_file(file, true, true)
      end

      # start loop.
      @notifier.run
      puts 'Watcher is started.'
    end

    # watch all exist files modify event.
    def start_watch_files
      watched_files.each do |file|
        @notifier.watch(file, :modify) do
          Js2coffee.compile_file(file, true, true)
        end
      end
    end

    def watched_files
      watched_files = Dir["./**/*.#{$script_extname}"]
      if ENV['JS2COFFEE_EXCLUDE_PATTERN']
        watched_files.reject! {|e| e =~ Regexp.union(ENV['JS2COFFEE_EXCLUDE_PATTERN']) }
      end
      watched_files
    end
  end
end
