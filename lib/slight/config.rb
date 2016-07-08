module Slight
	class Configure
		NoQuote = 0
		def initialize(options)
			@options = options
			yield
		end

		def add_attribute_rule(pattern, replacement, quote=1)
			@options[:attr_rule] ||= {}
			@options[:attr_rule][pattern.to_sym] = [replacement, quote]
		end

		def add_tag_rule(pattern, replacement)
			@options[:tag_rule] ||= {}
			@options[:tag_rule][pattern.to_sym] = replacement
		end

		def blinding(*system_fun)
			@options[:blinding] = system_fun.map(&:to_sym)
		end
	end
end