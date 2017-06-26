module C80Yax
  class Engine < ::Rails::Engine
    config.autoload_paths += %W(#{config.root}/app/models/c80_yax/concerns)
    config.i18n.load_path += Dir[config.root.join('config', 'locales', '*','*.{yml}').to_s]
    isolate_namespace C80Yax

    initializer :c80_yax_engine do
      if defined?(ActiveAdmin)
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/helpers/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/**/"]
        #ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/concerns/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/admin/c80_yax/**/"]
        # ActiveAdmin.application.load_paths += Dir["#{config.root}/app/jobs/**/"]
      end
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

  end
end