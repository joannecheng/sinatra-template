require 'bundler'
Bundler.require

module AssetHelpers
  def asset_path(source)
    "/assets/" + settings.sprockets.find_asset(source).digest_path
  end
end

class EducationStats < Sinatra::Base
  set :root, File.expand_path('../', __FILE__)
  set :sprockets, Sprockets::Environment.new(root)
  set :precompile, [/\w+\.(?!js|css).+/, /applcation.(css|js)$/]
  set :precomile, [/.*/]
  set :assets_prefix, 'assets'
  set :assets_path, File.join(root, 'public', assets_prefix)

  configure do
    sprockets.append_path(File.join(root, 'assets', 'javascripts'))
    sprockets.append_path File.expand_path('assets/stylesheets', settings.root)
    sprockets.append_path File.expand_path('assets/images', settings.root)

    sprockets.context_class.instance_eval do
      include AssetHelpers
    end
  end

  helpers do
    include AssetHelpers
  end

  get '/' do
    haml :index
  end
end
