require 'c80_lazy_images'

module Ti
  class ApplicationController < ActionController::Base

    helper C80LazyImages::Engine.helpers

  end
end
