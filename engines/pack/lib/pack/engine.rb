module Pack
  class Engine < ::Rails::Engine
    config.i18n.load_path += Dir[config.root.join('config', 'locales', '*','*.{yml}').to_s]
    isolate_namespace Pack

    initializer :pack_engine do
      # byebug
      if defined?(ActiveAdmin)
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/helpers/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/admin/**/"]
      end
    end

    initializer :append_migrations do |app|
      # byebug
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end

  end
end