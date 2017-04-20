require 'tilt'
require 'slght/tilt'

script = %{
	div "btn btn-succes #{btn_size}" do 
		@btn_txt
	end
}

@btn_txt = 'Click Me'
body = Proc.new { script }

template = Tilt.new(__FILE__, 6, {}，&body)
template.render(self, :btn_size => "btn lg")