module C80Yax
  module Mixins
    module Strsubcat
      module Database
        module Props
          # выдать collection of `main props`, связанных с этой подкатегорией
          def main_props_collection
            C80Yax::PropName
                .includes(:strsubcats)
                .where(:c80_yax_strsubcats => {:id => self.id})
          end

          # выдать collection of `price props` associated with this Strsubcat
          def price_props_collection
            C80Yax::PropName
                .includes(:strsubcats)
                .where(:c80_yax_strsubcats => {:id => self.id})
                .where(:c80_yax_prop_names => {:is_normal_price => 1})
          end

          # выдать collection of `common props` associated with this Strsubcat
          def common_props_collection
            C80Yax::PropName
                .includes(:strsubcats)
                .where(:c80_yax_strsubcats => {:id => self.id})
          end

          def prefix_props_collection
            C80Yax::PropName
                .includes(:strsubcats)
                .where(:c80_yax_strsubcats => {:id => self.id})
          end
        end
      end
    end
  end
end