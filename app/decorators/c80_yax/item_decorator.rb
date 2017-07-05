module C80Yax
  class ItemDecorator < ::ApplicationDecorator
    decorates 'C80Yax::Item'
    delegate_all

    def my_url
      "/katalog/#{model.strsubcat.slug}/#{model.id}"
    end

    def main_image(thumb_size = 'thumb_md', options = {})

      rel = options.fetch(:rel, 'follow')
      a_href = options.fetch(:a_href, my_url)

      ww = fetch_ww(thumb_size)
      hh = fetch_hh(thumb_size)

      h.render_image_link_lazy({
                                   :alt_image => model.title,
                                   # :image => main_image_tag(thumb_size),
                                   :image => self.fetch_first_photo(thumb_size),
                                   :a_href => a_href,
                                   :rel => rel,
                                   :a_class => 'item_main_image',
                                   :a_css_style => "width:#{ww}px;height:#{hh}px",
                                   :image_width => ww,
                                   :image_height => hh
                               })
    end

    def h3_title(thumb_size = 'thumb_md')
      ww = fetch_ww(thumb_size)
      h.content_tag :h3, model.title, style: "width:#{ww}px"
    end

    def div_prices
      # Rails.logger.debug '[TRACE] <ItemDecorator.div_prices> ------[begin]--------'
      result = ''

      if model.is_ask_price
        result =
            "<p class='is_ask_price c80_refine_price_button'
              data-item-url='#{ my_url }'
              data-item-id='#{ model.id }'
              data-item-title='#{ model.title }'>Уточнить цену</p>
          "
      else

        # <editor-fold desc="# парсим данные в структуру для view">
        props = {
            titles:     [],
            values:     [],
            uoms:       [],
            values_old: []
        }

        model.item_props.each do |ip|
          # Rails.logger.debug "[TRACE] <ItemDecorator.div_prices> ip.prop_name.related.present? = #{ip.prop_name.related.present?}"
          if ip.prop_name.is_normal_price
            props[:titles] << ip.prop_name.title
            props[:values] << ip.value
            props[:uoms] << ip.prop_name.uom_title

            # у свойства "нормальная цена" может быть "старый вариант"
            if ip.prop_name.related.present?
              # фиксируем  айдишник свойства "старый вариант этой цены"
              related_id = ip.prop_name.related.id
              # и зафиксирем его значение
              model.item_props.each do |iip|
                # Rails.logger.debug "[TRACE] <ItemDecorator.div_prices> iip.prop_name.id = #{iip.prop_name.id} VS #{related_id}"

                if iip.prop_name.id == related_id
                  # props[:titles] << iip.prop_name.title
                  props[:values_old] << iip.value
                  # props[:uoms] << iip.prop_name.uom_title
                  break
                end
              end
            end

          end
        end

        # Rails.logger.debug "[TRACE] <ItemDecorator.div_prices> props: #{props}"

        # </editor-fold>

        # <editor-fold desc="# собираем html-строку (список)">
        res = ''
        props[:titles].each_with_index do |title, i|
          e = "<p data-title='#{title}' class='old'><span class='pvalue bold'>#{props[:values_old][i]}</span> <span class='puom'>#{_uom(props[:uoms][i])}</span></p>" # 1212,80 руб
          e += "<p data-title='#{title}'><span class='pvalue bold'>#{props[:values][i]}</span> <span class='puom'>#{_uom(props[:uoms][i])}</span></p>" # 1212,80 руб
          e = "<li>#{e}</li>"
          res += e
        end

        # Rails.logger.debug '[TRACE] <ItemDecorator.div_prices> ------- [end] ------- '
        result = "<ul>#{res}</ul>"
        # </editor-fold>

      end

      "<div class='price_props'>#{result}</div>".html_safe

    end

    def _uom(v)
      return '' if v.nil?
      v
    end

    def btn_order

    end


    def h1_title
      h.content_tag :h1, model.title
    end

    def props_list
      res = ''
      ps = %w(customer price duration when)
      ds = %w(клиент бюджет срок\ выполнения дата)
      ps.each_with_index do |p, index|
        v = model.send(p)
        next if v.blank?
        res += "<li><span class='def'>#{ds[index]}:</span> #{model.send(p)}</li>"
      end
      "<ul class='work_props_list'>#{res}</ul>".html_safe
    end

    def images_no_main(thumb_size = 'thumb_sm')
      res = ''
      model.iphotos.each_with_index do |wp, index|
        next if index.zero?
        img = h.image_tag wp.image.send(thumb_size).url
        lnk = h.link_to img, wp.image.thumb_lg.url
        res += "<li>#{lnk}</li>"
      end
      "<ul class='item_images_no_main'>#{res}</ul>".html_safe
    end

    def div_p_desc
      res = ''
      res = model.desc.html_safe if model.desc.present?
      "<div class='work_desc'>#{res}</div>".html_safe
    end


    # выдать url миниатюры указанного +thumb_size+ типа
    # первой попавшейся фотки обьекта
    def fetch_first_photo(thumb_size = 'thumb_md')
      Rails.logger.debug '[TRACE] <ItemDecorator.fetch_first_photo>'
      res = ''
      if model.iphotos.size > 0
        res = model.iphotos.first.image.send(thumb_size)
      end
      res
    end

    def fetch_ww(thumb_size = 'thumb_md')
      Rails.logger.debug '[TRACE] <ItemDecorator.fetch_ww>'
      @ww ||= ItemPhotosSizesCache.instance.thumb_width(thumb_size)
    end

    def fetch_hh(thumb_size = 'thumb_md')
      Rails.logger.debug '[TRACE] <ItemDecorator.fetch_hh>'
      @hh ||= ItemPhotosSizesCache.instance.thumb_height(thumb_size)
    end

  end
end