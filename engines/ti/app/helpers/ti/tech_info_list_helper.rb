module Ti
  module TechInfoListHelper

    def render_tech_info_list(&make_doc_url)

      p_make_doc_url = Proc.new &make_doc_url

      res = ''

      cds = Category.includes(:docs) #where(ti_categories: {is_listed: true})

      cds.each do |c|
        next unless c.is_listed
        cc = "<h2>#{c.title}</h2>"
        cc += ul_docs_of_cats(c.child_categories, p_make_doc_url)
        cc = "<li>#{cc}</li>"
        res += cc
      end

      "<ul class='tech_info_list'>#{res}</ul>".html_safe

    end

    private

    def ul_docs_of_cats(list_of_categories, p_make_doc_url)
      res = ''

      list_of_categories.each do |cat|
        cc = "<h3>#{cat.title}</h3>"
        cc += ul_docs(cat, p_make_doc_url)
        cc = "<li>#{cc}</li>"
        res += cc
      end

      "<ul class='docs_of_cats'>#{res}</ul>"

    end

    def ul_docs(cat, p_make_doc_url)
      res = ''

      cat.docs.each do |doc|
        cc = "<a href='#{p_make_doc_url.call(doc)}' title='#{doc.title}'>#{doc.title}</a>"
        cc = "<li>#{cc}</li>"
        res += cc
      end

      "<ul class='docs'>#{res}</ul>"

    end

  end
end