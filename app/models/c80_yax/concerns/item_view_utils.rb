module C80Yax
  module Concerns
    module ItemViewUtils
      extend ActiveSupport::Concern
      include ActionView::Helpers::AssetTagHelper
      include ActionView::Helpers::UrlHelper

      # вывести первую фотку и кол-во всего
      # noinspection RubyResolve
      def iphotos_short_view
        r = ''
        if self.iphotos.count > 0
          r = link_to image_tag(self.iphotos.first.image.thumb_md,
                                style: 'width:150px'),
                      self.iphotos.first.image.url,
                      target: '_blank'
          r = "#{r}<br><sup>Всего фотографий: #{self.iphotos.count}</sup>".html_safe
        end
        r
      end

    end
  end
end