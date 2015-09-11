module Js2coffee
  class PathHelper
    attr_reader :path

    def initialize(path)
      @path = Pathname(path)
    end

    def create_js_path!
      # if find `coffee' in descend path, will create js directory at the same level.
      path.descend do |x|
        if x.basename.to_s == 'coffee'
          js_path = path.sub('/coffee/', '/js/').sub_ext('.js')
          map_path = path.sub('/coffee/', '/.map/').sub_ext('.js.map')

          FileUtils.mkdir_p([js_path.dirname, map_path.dirname])

          return [js_path, map_path]
        end
      end

      # else, just save in the same path with new extname.
      js_path = path.sub_ext('.js')
      map_path = path.sub_ext('.js.map').sub(/\/([^\/]+)$/, '/.\1')
      fail 'filename extension must .coffee!' if path == js_path

      [js_path, map_path]
    end

    def create_coffee_path!
      path.descend do |x|
        if x.basename.to_s == 'js'
          js_path = path.sub('/js/', '/coffee/').sub_ext('.coffee')
          map_path = path.sub('/js/', '/.map/').sub_ext('.js.map')

          FileUtils.mkdir_p([js_path.dirname, map_path.dirname])

          return [js_path, map_path]
        end
      end

      js_path = path.sub_ext('.coffee')
      map_path = path.sub_ext('.js.map').sub(/\/([^\/]+)$/, '/.\1')
      fail 'filename extension must .js!' if path == js_path

      [js_path, map_path]
    end
  end
end
