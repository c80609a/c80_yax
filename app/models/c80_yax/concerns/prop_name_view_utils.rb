module C80Yax
  module Concerns
    module PropNameViewUtils
      extend ActiveSupport::Concern
      include C80Yax::UomHelper

      def title_with_uom
        res = self.title
        res += pretty_uom_print(uom)
        res
      end

    end
  end
end