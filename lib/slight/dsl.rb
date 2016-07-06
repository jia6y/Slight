module Slight
	module DSL
		def echo(str)
			@output_buffer << str
		end

		#def __dsl__transform(file_path)
		#	cur = @output_buffer.pos
		#	eval(IO.read(find_file), nil, find_file, __LINE__)
		#	@output_buffer.pos = cur == 0 ? 0 : cur + 1
		#end

		def __dsl__define(dsl)
			DSL.send(:define_method, dsl){|*param|
				__dsl__packup(dsl,*param)
			}
		end

		def __dsl__packup(tag, attribute)
			tag = tag.to_s
			tag.sub!(/^_/,'') if tag.start_with?('_')

			#attribute = @filter.lookup(param)

			echo "<#{tag}"; echo " #{attribute}" if attribute != ''; echo ">"
			sub = yield if block_given?
			echo sub.to_s if sub.class != Hash && sub.class != Array 
			echo "</#{tag}>"
		end

	end
end








