require 'turbolinks_render/version'
require 'turbolinks_render/rendering'
require 'turbolinks_render/middleware'

module TurbolinksRender
  class TurbolinksRenderMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @status, @headers, @response = @app.call(env)
    end
  end

  class Engine < ::Rails::Railtie
    config.turbolinks_render = ActiveSupport::OrderedOptions.new
    config.turbolinks_render.render_with_turbolinks_by_default = true

    initializer :turbolinks_render do |app|
      app.config.app_middleware.use TurbolinksRender::Middleware

      ActiveSupport.on_load(:action_controller) do
        include Rendering
      end
    end
  end
end

