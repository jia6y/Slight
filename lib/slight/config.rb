require 'slight/delegation'

module Slight
  class Configuration
    
    def configure(options = {}, &blk)
      @options = options
      blk.call self
      @options
    end

    def use(t, d = '<')
      @options[:prep] ||= []
      d == '<' ? @options[:prep].push(t) : @options[:prep].unshift(t)
    end

    def shortcut(type, pattern, *replacement)
      case(type) 
      when :A
        @options[:shortcutA] ||= {}
        @options[:shortcutA][pattern.to_sym] = replacement
      when :T 
        @options[:shortcutT] ||= {}
        @options[:shortcutT][pattern.to_sym] = replacement
      end
    end

    def blinding(*system_fun)
      @options[:blinding] = system_fun.map(&:to_sym)
    end

  end
end

delegate :configure, "Slight::Configuration.new"
