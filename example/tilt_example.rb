require 'slght/tilt'
require 'tilt'



template_script = %{
	div "btn btn-succes #{btn_size}" do 
		@btn_txt
	end
}

@btn_txt = 'Click Me'

template = Tilt.new(__FILE__, 6, {})
#<Tilt::LiquidTemplate @file='hello.liquid'>
scope = { :title => "Hello Liquid Templates" }
template.render(self, :world => "Liquid")
    => "
    <html>
      <head>
        <title>Hello Liquid Templates</title>
      </head>
      <body>
        <h1>Hello Liquid!</h1>
      </body>
    </html>"