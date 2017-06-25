module C80Yax
  module Mixins
    module Cat
      module Database

        def self.included(base)
          base.extend(ClassMethods)
          base.instance_eval do
            scope :menu_order, -> {order(:ord => :asc)}
          end
        end

        module ClassMethods



          # выдать первые N категорий, отсортированные
          # в ord порядке

          def iconed_list(n)
            self.menu_order.limit(n)
          end

        end
      end
    end
  end
end