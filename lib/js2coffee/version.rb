#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

module Js2coffee
  VERSION = [1, 0, 0]

  class << VERSION
    def to_s
      join(?.)
    end
  end
end
