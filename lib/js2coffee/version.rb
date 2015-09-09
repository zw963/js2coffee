#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module Js2coffee
  VERSION = [0, 11, 0]

  class << VERSION
    def to_s
      join(?.)
    end
  end
end
