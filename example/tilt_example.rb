$:.unshift File.expand_path('../../lib', __FILE__)
require 'slight/tilt'

script = %q{
	div "btn btn-succes #{btn_size}" do 
		@btn_txt	
	end
}

@btn_txt = 'Pls,Click-Me.'
body = Proc.new { script }

template = Tilt.new('tilt_example.rb', 5, {}, &body)
puts template.render(self, :btn_size => "btn-lg")

# <div class="btn btn-succes btn-lg">
#     Pls,Click-Me.
# </div>
