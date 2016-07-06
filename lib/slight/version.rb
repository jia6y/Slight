module Slight
  # Slight version string
  # @api public
  VERSION = '0.0.1'

end

class A
	private
	def method_missing(fun, *param, &block)
			p fun
			p 123
	end

	def h
		p 'hhhhh'
	end
end


class B < A 
end

b= B.new
b.hello
b.h

{:s=>2}.each_pair{|k,v|
	p k
}

