# Slight-lang
A light and sweet template language. (in progress, 90%)

## Description
Slight is a very simple and easy to use template language.
Advantage of Slight:
- Pure Ruby syntax
- Html friendly
- Nearly 0 learning cost

## Quick Start
#### [Installtion]
```
gem install slight-lang  (not ready)

# you can also build gem from gemspec
gem build slight.gemspec
gem install ./slight-lang-1.0.1.gem
```

#### [Command]
###### Slight
```bash
slight [-v] <source> [<output>]

e.g.
slight index.slight index.htm
=> index.htm

slight index.slight
=> <tag>abcde</tag>

slight -v
=> v 1.0.1
```

###### REPL
```
slsh
```
- build-in commands

```ruby
# help
sl:> \h
 @file    => load and compile file dynamically. E.g. @/tmp/page.slight
 >@       => set output. E.g. Open: >@/tmp/output. Turn off: >@off
 \eg      => example
 \q       => exit
 \v       => show version (also: \ver, \version)


# exit
sl:> \q  (ctrl + c)
*** Exit now ***
--bye--


# show example
sl:> \eg
    button "btn btn-primary" do
      "Click me"
    end
=>
    <button class="btn btn-primary">Click me</button>


# compile slight file
sl:> @../../example/component.slight.rb
LOAD PATH="../../example/component.slight.rb"
<button class="btn btn-success btn-lg">
submit</button>


# redirect output to file
sl:> >@output.htm  (>@off to turn off)
spool turned on
OUTPUT PATH="output.htm"
```
- Run Slight in REPL

```ruby
sl:> button 'btn btn-success btn-lg', name:'btn_submit', type:'submit' do
sl:>    "Submit"
sl:> end
sl:> ;   (Enter ';' to run the script)

<button class="btn btn-success btn-lg" name="btn_submit" type="submit">
Submit</button>
```

#### [Syntax]

- Pure Ruby Syntax

```ruby
tag_name "class", [attributes: id, name, style, etc.] do; <content>; end

e.g.
div "panel panel-lg", css: "border: 5 dotted green", id: "msgbox" do
  button "btn btn-primary" do
    "Ok"
  end
  button "btn btn-default" do
    "Cancel"
  end
end

(of course {} syntax is also spported)
```
- All html tags are supported

- Default Build-in Html Shortcuts

```ruby  
[attribute]
  css   => "style"
  ln    => "href"
  url   => "href"
  char  => "charset"
  fn    => "src"
  lang  => "language"
  xn    => "xmlns"
  mf    => "manifest"

e.g.

  div css:'border: 10 solid blue' do; "hello"; end
=>
  <div style="border: 10 solid blue">
    Hello
  <div>

[tag]
  _     => "<div>$content</div>"
  js    => "<script language='javscript'>$content</script>"
  use   => "<script type='text/javascript' src='$content'></script>"
  use   => "<link rel='stylesheet' href='$content'></link>"
  # depends on which file loaded 'use' will determine which tag to replace.

e.g.

  _ do; "hello"; end
=>
  <div>hello</div>


  js %{
    console.log("hello slight");
  }
=>
  <script language="javascript">
    console.log("hello slight");
  </script>


  use 'resource/bootstrap.js'
=>
  <script type='text/javascript' src='resource/bootstrap.js'></script>


  use 'resource/bootstrap.css'
=>
  <link rel='stylesheet' href='resource/bootstrap.css'></link>
```

#### [Customize]
- general usage (more details please refer to example)

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

Any questions or suggestions are welcome. You can reach me at: nemo1023#gmail.com
