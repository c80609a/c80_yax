require 'c80_lazy_images'

module Ti
  class ApplicationController < ActionController::Base

    helper C80LazyImages::Engine.helpers

    def guru
      respond_to do |format|
        format.js
      end
    end
  end
end
