#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module CoffeeWithoutNodejs
  VERSION = [0, 7, 0]

  class << VERSION
    def to_s
      join(?.)
    end
  end
end
