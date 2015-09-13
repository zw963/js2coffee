module Js2coffee
  class PathHelper
    attr_reader :path

    def initialize(path)
      @path = Pathname(path)
    end

    def create_target_path!
      # if find `coffee' in descend path, will create js directory at the same level.
      ext = path.extname[1..-1]
      target = ext == 'js' ? 'coffee' : 'js'

      path.descend do |x|
        if x.basename.to_s == ext
          target_path = path.sub("/#{ext}/", "/#{target}/").sub_ext(".#{target}")
          map_path = path.sub("/#{ext}/", '/.map/').sub_ext('.js.map')

          FileUtils.mkdir_p([target_path.dirname, map_path.dirname])

          return [target_path, map_path]
        end
      end

      # else, just save in the same path with new extname.
      target_path = path.sub_ext(".#{target}")
      map_path = path.sub_ext('.js.map').sub(%r{/([^/]+)$}, '/.\1')
      fail "filename extension must .#{ext}!" if path == target_path

      [target_path, map_path]
    end
  end
end
