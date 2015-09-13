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
        Js2coffee.watch_file(file)
      end

      # start loop.
      @notifier.run
      puts 'Watcher is started.'
    end

    private

    # watch all exist files modify event.
    def start_watch_files
      watched_files.each do |file|
        @notifier.watch(file, :modify) do
          Js2coffee.watch_file(file)
        end
      end
    end

    def watched_files
      watched_files = Dir["./**/*.#{$script_extname}"]
      exclude_pattern = ['node_modules|bower_components'] << ENV['JS2COFFEE_EXCLUDE_PATTERN']

      watched_files.reject! {|e| e =~ /#{exclude_pattern.join('|')}/ }
      watched_files
    end
  end
end
