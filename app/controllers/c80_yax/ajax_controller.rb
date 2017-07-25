module C80Yax
  class AjaxController < ::ApplicationController

    def fetch_items

      @params = _make_params
      # params: {
      # type:'hit',
      # ajax_items: '.div_hot_items .ajax_items',
      # page: 1,
      # per_page: 4
      # slug: ...

      case @params[:type]
        when 'hit'
          @itms = Item.where(is_hit: true)
                     .includes(item_props: {prop_name: [:uom, :related]})
                     .includes(:iphotos)
                     .includes(:strsubcat)
                     .paginate(page: @params[:page], per_page: @params[:per_page])
        when 'offer'
          @itms = Item.joins(:offers)
                     .includes(item_props: {prop_name: [:uom, :related]})
                     .includes(:iphotos)
                     .includes(:strsubcat)
                     .paginate(page: @params[:page], per_page: @params[:per_page])
        when 'cat'
          @itms = C80Yax::Item.includes(item_props: {prop_name: [:uom, :related]})
                      .includes(:iphotos)
                      .includes(strsubcat: :cats)
                      .where(c80_yax_cats: {slug: params[:slug] })
                      .paginate(page: @params[:page], per_page: @params[:per_page])
      end

      @items = ItemDecorator.decorate_collection(@itms)

    end

    private

    def _make_params

      result = {}
      result[:page] = 1
      result[:per_page] = 4
      result[:type] = 'hit'
      result[:ajax_items_div] = ''

      # result[:sorting_type] = -1 # TODO:: убрать хардкод: здесь должно быть обращение к таблице SortingTypes и поиск в ней "сортировки по умолчанию"
      # result[:strsubcat_id] = nil

      if params[:page].present?;
        result[:page] = params[:page];
      end
      if params[:per_page].present?;
        result[:per_page] = params[:per_page];
      end
      if params[:type].present?;
        result[:type] = params[:type];
      end
      if params[:ajax_items_div].present?;
        result[:ajax_items_div] = params[:ajax_items_div];
      end
      # if params[:sorting_type].present?; result[:sorting_type] = params[:sorting_type]; end
      # if params[:strsubcat_id].present?
      #   result[:strsubcat_id] = params[:strsubcat_id]
      # end

      Rails.logger.debug "[TRACE] <stroy_mat_params_helper.smph_make_params> Обрабатываем параметры: @params = #{result}"
      result

    end

  end
end