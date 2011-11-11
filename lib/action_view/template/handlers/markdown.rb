module ActionView 
  module Template::Handlers
    class Markdown < ERB
      def self.call(template)
        new.compile(template)
      end

      def compile(template)
        html = ::RDiscount.new(template.source).to_html
        erb = html.gsub /\{\{(.*?)\}\}/, '<%= \1 %>'
        self.class.erb_implementation.new(erb).src
      end
      
    end
  end
  Template.register_template_handler :markdown, Template::Handlers::Markdown
end
