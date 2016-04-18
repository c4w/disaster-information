module JekyllPagesApi
  class Page
    def date
      (self.page.data['date'] if self.page.respond_to?(:data)) || ""
    end

    def lang
      (self.page.data['lang'] if self.page.respond_to?(:data)) || "ja"
    end

    def meta
      (self.page.data['meta'] if self.page.respond_to?(:data)) || {}
    end

    def body_text
      output = self.page.content if self.page.respond_to?(:content)
      output ||= File.read(self.page.path)
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

  class Generator
    def langs
      langs = []
      pages_data.each do |d|
        langs << d[:lang]
      end
      langs.uniq
    end

    def data
      data = {}

      langs.each do |l|
        data[l] = {
          entries: []
        }
      end

      pages_data.each do |d|
        data[d[:lang]][:entries] << d
      end

      data
    end

    def jsons
      jsons = []
      langs.each do |l|
        json = PageWithoutAFile.new(site,
                                    File.dirname(__FILE__),
                                    dest_dir,
                                    "#{l}.json")
        json.output = data[l].to_json
        jsons << json
      end
      jsons
    end

    def generate
      jsons.each do |j|
        site.pages << j
      end
    end
  end
end
