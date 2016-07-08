module Slight
  module Configure
    NoQuote = 0
    def self.set(options = {})
      @options = options
      yield
      @options
    end

    def self.attr_shortcut(pattern, replacement, quote=1)
      @options[:attr_shortcut] ||= {}
      @options[:attr_shortcut][pattern.to_sym] = [replacement, quote]
    end

    def self.tag_shortcut(pattern, replacement)
      @options[:tag_shortcut] ||= {}
      @options[:tag_shortcut][pattern.to_sym] = replacement
    end

    def self.blinding(*system_fun)
      @options[:blinding] = system_fun.map(&:to_sym)
    end

  end
end
