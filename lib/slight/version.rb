module Slight
  # Slight version string
  # @api public
  VERSION = '0.0.1'

end

#class A
#
#	def call_yield!
#		p 'call_yield'
#		yield!
#	end
#
#	private
#	def method_missing(fun, *param, &block)
#		puts "missing #{fun}"
#	end
#
#	def h
#		p 'hhhhh'
#		yield!
#	end
#
#	def yield!
#		p 'yield!'
#	end
#end
#
#
#class B < A 
#end
#
#b= B.new
##b.hello
##b.h
##b.call_yield
##
##{:s=>2}.each_pair{|k,v|
##	p k
##}
#
#b.instance_eval{
#	def _(str, attributes={})
#		puts "<div class=#{str} f=#{attributes[:f]}></div>"
#	end
#
#	
#	def ss
#		b = binding
#		b.local_variable_set(:a113, 'hello binding')
#		src=%q[
#			p a113
#			hh
#			_'btn btn-primary', f:1 do
#
#			end
#
#		]
#		eval(src, b)
#	end
#
#	def hh
#		p 'called haha'
#	end
#}
#
#p b.singleton_methods
#b.ss
#
#def d(aa)
#	p aa
#end
#d ['222']
#
#
#class BBB
#	def s
#		@sss
#	end
#end
#
#class AAA < BBB
#	def b
#		@sss=567
#	end
#end
#
#a = AAA.new
#p a.b
#p a.s


class A
	def say
		p @name
	end
end

A.class_eval do 
	@name = 'Hello'
end

a=A.new
a.say

a.singleton_class.class_eval do 
	undef :p
end

a.instance_eval do 
	@name = 'Oliver'
end

a.singleton_class.class_eval do 
	def p(str)
		puts "=> :#{str}"
	end
end

a.say

b=A.new
b.say

def fun(tag, *at)
	replacements={ln:'href'}
	attrs=[]
	at.each do |var| 
		var.each_pair do |a, v|
			unless a.to_sym == :_ then
				a = replacements.fetch(a,a)
				a = v.class == String ? "#{a}=\"#{v}\"" : "#{a}=#{v.to_s}"
			else
				a = "#{v}"
			end
			attrs.push a
		end
	end
	content = yield if block_given?
	space = attrs.length > 0 ? ' ' : ''
	"<#{tag}#{space}" + attrs.join(" ") + ">#{content}</#{tag}>"
end


msg = fun 'div', name:'div_1', _:'h' , id:12  do 
				fun 'p' do 
					fun 'span', css:'color:red', ln:'/index.slight'  do
						fun 'button', id:123, value:123, onclick:'call(123)'
					end
				end
			end

puts msg

p 'as adddd'.split(' ')[0]
p 'as adddd'.split(':')[0]

module CM
	def c
		puts "called CM#c"
	end
end

class CC
	extend CM
end

CC.c
p "hello Oliver:   This is Nemo".gsub(/\s/, "&nbsp;")




