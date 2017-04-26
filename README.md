# Slight-lang
A light and sweet template language.

with:
- Pure Ruby syntax
- Html friendly
- 0 learning cost

## Quick Start
#### [Installation]
```
gem install slight-lang

# you can also build gem from gemspec
# gem build slight.gemspec
# gem install ./slight-lang-1.0.5.gem
```

#### [Usage]
###### Command
```bash
root@ubuntu:/# slight [-v] <source> [<output>]

# slight index.slight index.htm
# => index.htm
```

###### REPL
```bash
root@ubuntu:/# slsh
```
```ruby
# help
sl:> \h
 @file    => load and compile file dynamically. E.g. @/tmp/page.slight
 >@       => set output. E.g. Open: >@/tmp/output. Turn off: >@off
 \eg      => example
 \q       => exit
 \v       => show version (also: \ver, \version)

# example
sl:> button 'btn btn-success btn-lg', name:'btn_submit', type:'submit' do
sl:>    "Submit"
sl:> end
sl:> ;   (Enter ';' to run the script)

# compile from file
sl:> @../../example/component.slight.rb
LOAD PATH="../../example/component.slight.rb"

# redirect output to file
sl:> >@output.htm  (>@off to turn off)
spool turned on
OUTPUT PATH="output.htm"
```

#### [Syntax]

- Pure Ruby Syntax

```ruby
tag_name "class", [attributes: id, name, style, etc.] do; <content>; end

# example
div "panel panel-lg", css: "border: 5 dotted green", id: "msgbox" do
  button "btn btn-primary" do
    "Ok"
  end
  button "btn btn-default" do
    "Cancel"
  end
end
```
- All html tags are supported

-- Attribute Shortcuts

| shortcut | attribute |
|-------|--------------|
| css | style |
| ln | href |
| url | href |
| char | charset |
| fn | src |
| lang | language |
| xn | xmlns |
| mf | manifest |

```ruby  
# example
  div css:'border: 10 solid blue' do; "hello"; end
# <div style="border: 10 solid blue">
#   Hello
# <div>
```

-- Html Tag Shortcuts

| shortcut | attribute |
|-------|--------------|
| _ | <div>$content</div> |
| js | <script language='javscript'>$content</script> |
| use | <script type='text/javascript' src='$content'></script> |
| use | <link rel='stylesheet' href='$content'></link> |

```ruby
# example
  js %{
    console.log("hello slight");
  }
# <script language="javascript">
#   console.log("hello slight");
# </script>

  use 'resource/bootstrap.js'
# <script type='text/javascript' src='resource/bootstrap.js'></script>
```

#### [Customization]
- Usage (more details please refer to example)

```ruby
conf = Slight::Configuration.new do |c|
  c.shortcut :A, :endpoint, "href"  #add an attribute shortcut
  c.shortcut :T, "box", "div"       #add a tag shortcut
end

custom_engine = Slight::Engine.new(conf)
```

- supported configuration

```ruby
conf = Slight::Configuration.new do |c|
  c.shortcut :A, :endpoint, "href"  #add an attribute shortcut
  c.shortcut :T, "box", "div"       #add a tag shotcut

  # set output IO
  c.setIO        STDOUT
  # undef ruby methods in slight context
  c.blinding     :p, :select, :puts, :send, :class

  # use Filter
  # Before-Filters accept original source pass the output to Slight compiler.
  # After-Filters accept output from Slight compiler pass the output to end user.
  c.use     FilterA, :before
  c.use     FilterB, :after
end
```

#### [Tilt Intergration]
- Working with Tilt
```ruby
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
```


Any questions or suggestions are welcome. You can reach me at: nemo1023#gmail.com
