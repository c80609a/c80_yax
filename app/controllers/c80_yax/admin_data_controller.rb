module C80Yax
  class AdminDataController < ApplicationController

    # http://stackoverflow.com/questions/5130150/rails-how-to-use-a-helper-inside-a-controller
    include DataHelper

    def get_strsubcat_propnames
      Rails.logger.debug '[TRACE] <admin_data_controller.get_strsubcat_propnames> Получить список имён свойств данной подкатегории.'
      Rails.logger.debug "[TRACE] <admin_data_controller.get_strsubcat_propnames> request: #{request.request_parameters}"

      strsubcat_id = request.params[:strsubcat_id]

      obj = stdh_get_strsubcat_propnames(strsubcat_id)

      respond_to do |format|
        format.js { render json: obj, status: :ok }
      end

    end

  end
end