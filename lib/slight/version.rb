module Slight
  # Slight version string
  # @api public
  VERSION = '0.0.1'

end

class A

	def call_yield!
		p 'call_yield'
		yield!
	end

	private
	def method_missing(fun, *param, &block)
			p fun
			p 123
	end

	def h
		p 'hhhhh'
		yield!
	end

	def yield!
		p 'yield!'
	end
end


class B < A 
end

b= B.new
b.hello
b.h
b.call_yield

{:s=>2}.each_pair{|k,v|
	p k
}

