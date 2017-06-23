module C80Yax
  module PropNameHelper

    def title_with_uom(prop_name)
      res = prop_name.title
      res += pretty_uom_print(prop_name.uom)
      res
    end

  end
end