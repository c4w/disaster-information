module JekyllPagesApi
  class Page
    def date
      (self.page.data['date'] if self.page.respond_to?(:data)) || ""
    end
    def lang
      (self.page.data['lang'] if self.page.respond_to?(:data)) || "ja"
    end
    def meta
      (self.page.data['meta'] if self.page.respond_to?(:data)) || []
    end
    def to_json
      optional = {}
      optional['skip_index'] = true if self.skip_index?
      optional.merge({
        title: self.title,
        date: self.date,
        url: self.url,
        tags: self.tags,
        lang: self.lang,
        meta: self.meta,
        body: self.body_text
      })
    end
  end
  # class Generator
  #   def page
  #     # based on https://github.com/jekyll/jekyll-sitemap/blob/v0.7.0/lib/jekyll-sitemap.rb#L51-L54
  #     page = PageWithoutAFile.new(self.site, File.dirname(__FILE__), self.dest_dir, 'ja.json')
  #     p self.data
  #     page.output = self.data.to_json
  #     page
  #   end
  # end
end
