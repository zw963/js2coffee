#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require File.expand_path('../lib/js2coffee/version', __FILE__)

Gem::Specification.new do |s|
  s.name                        = 'js2coffee'
  s.version                     = Js2coffee::VERSION
  s.date                        = Time.now.strftime('%F')
  s.required_ruby_version       = '>= 1.9.1'
  s.authors                     = ['Billy.Zheng(zw963)']
  s.email                       = ['zw963@163.com']
  s.summary                     = 'Convert yours JavaScript code to CoffeeScript,  vice versa.'
  s.description                 = 'Convert yours JavaScript code to CoffeeScript,  vice versa.'
  s.homepage                    = 'http://github.com/zw963/js2coffee'
  s.license                     = 'MIT'
  s.require_paths               = ['lib']
  s.files                       = `git ls-files bin lib *.md LICENSE`.split("\n")
  s.executables                 = `git ls-files -- bin/*`.split("\n").map {|f| File.basename(f) }

  s.add_runtime_dependency 'execjs', '~>2.2'
  s.add_runtime_dependency 'rb-inotify', '~>0.9'
  s.add_runtime_dependency 'coderay', '~>1.1'
  s.add_development_dependency 'ritual', '~>0.4'
end
