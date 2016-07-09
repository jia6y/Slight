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
		puts "missing #{fun}"
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
#b.hello
#b.h
#b.call_yield
#
#{:s=>2}.each_pair{|k,v|
#	p k
#}

b.instance_eval{
	def _(str, attributes={})
		puts "<div class=#{str} f=#{attributes[:f]}></div>"
	end

	
	def ss
		b = binding
		b.local_variable_set(:a113, 'hello binding')
		src=%q[
			p a113
			hh
			_'btn btn-primary', f:1 do

			end

		]
		eval(src, b)
	end

	def hh
		p 'called haha'
	end
}

p b.singleton_methods
b.ss

def d(aa)
	p aa
end
d ['222']


class BBB
	def s
		@sss
	end
end

class AAA < BBB
	def b
		@sss=567
	end
end

a = AAA.new
p a.b
p a.s








