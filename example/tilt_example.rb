require 'tilt'
require 'slght/tilt'

script = %{
	div "btn btn-succes #{btn_size}" do 
		@btn_txt
	end
}

@btn_txt = 'Click Me'

template = Tilt.new(__FILE__, 6, {}，Proc.new { script })

scope = { :title => "Hello Liquid Templates" }
template.render(self, :btn_size => "btn lg")