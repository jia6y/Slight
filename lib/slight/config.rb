require 'slight/delegation'

module Slight
  class Configuration
    NoQuote = 0

    def configure(options = {}, &blk)
      @options = options
      blk.call self
      @options
    end

    def hh
      p 123
    end

    def use(template)
      [template.render]
    end

    def shortcut(type, pattern, *replacement)
      case(type) 
      when :A
        @options[:shortcutA] ||= {}
        @options[:shortcutA][pattern.to_sym] = replacement
      when :T 
        @options[:shortcutB] ||= {}
        @options[:shortcutB][pattern.to_sym] = replacement
      end
    end

    def blinding(*system_fun)
      @options[:blinding] = system_fun.map(&:to_sym)
    end

  end
end

delegate :configure, "Slight::Configuration.new"
