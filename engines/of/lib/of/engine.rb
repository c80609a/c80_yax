module Of
  class Engine < ::Rails::Engine
    isolate_namespace Of

    initializer :of_engine do
      if defined?(ActiveAdmin)
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/**/"]
        #ActiveAdmin.application.load_paths += Dir["#{config.root}/app/models/concerns/**/"]
        ActiveAdmin.application.load_paths += Dir["#{config.root}/app/admin/**/"]
        # ActiveAdmin.application.load_paths += Dir["#{config.root}/app/jobs/**/"]
      end
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end

  end
end