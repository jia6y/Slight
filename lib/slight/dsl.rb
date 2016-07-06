module Slight
	class DSL
		def initialize(io)
			@output_buffer = io
		end

		def echo(str)
			@output_buffer << str
		end

		def transform(file_path)
			cur = @output_buffer.pos
			eval(IO.read(find_file), nil, find_file, __LINE__)
			@output_buffer.pos = cur == 0 ? 0 : cur + 1
		end

		private 
		def define(dsl)
			self.class.send(:define_method, dsl){|*param|
				packup(dsl,*param)
			}
		end

		def packup(tag, attribute)
			tag = tag.to_s
			tag.sub!(/^_/,'') if tag.start_with?('_')

			#attribute = @filter.lookup(param)

			echo "<#{tag}"; echo " #{attribute}" if attribute != ''; echo ">"
			sub = yield if block_given?
			echo sub.to_s if sub.class != Hash && sub.class != Array 
			echo "</#{tag}>"
		end

		def method_missing(fun, *param, &block)
			define(fun)
			self.send(fun, *param, &block)
		end

	end
end








