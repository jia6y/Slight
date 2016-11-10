$:.unshift File.expand_path('../../lib', __FILE__)

require 'slight'
@default_engine = Slight::Engine.new

Signal.trap("INT") do
  puts "*** Exit now ***".light_blue
  puts "Terminating...".light_blue
  exit 1
end

def main
  print_logo
  buff = ""
  loop do
    print "sl:> "
    case line = STDIN.readline.sub(/[\n\r]/,'')
    when "\\h"
      print_help
    when "\\eg"
      print_example
    when "\\q"
      puts "*** Exit now ***".light_blue
      exit 0
    when /\\(v|version|ver)/
      puts "ver #{Slight::VERSION}\n\n"
    when /^@/
      fn = line.sub('@','')
      puts "LOAD PATH=\"#{fn}\"\n".light_blue
      sl_handler(fn, is_file=true)
      buff.clear
      puts ""
    when ""
      if buff.size > 0 then
        sl_handler(buff)
        buff.clear
        puts ""
      end
    else
      buff << line << "\n"
    end
  end
end

def sl_handler(buff, is_file=false)
  if is_file
    STDOUT.puts @default_engine.render(buff).green
  else
    STDOUT.puts @default_engine.render("console",buff).green
  end
rescue Slight::DSLException => errs
  STDERR.puts "Source Data Issue:".yellow
  STDERR.puts errs.message.red
  STDERR.puts [errs.inspect, errs.backtrace.join("\n")].join("\n").red
rescue Exception => errs2
  STDERR.puts errs2.message.red
  #STDERR.puts [errs2.inspect, errs2.backtrace.join("\n")].join("\n")
end

def print_help
  puts " @file    => load and compile file dynamically. E.g. @/tmp/page.slight".green
  puts " \\eg      => example".green
  puts " \\q       => exit".green
  puts " \\v       => show version (also: \\ver, \\version)".green
  puts
end

def print_example
  eg1_in=%{
1:
    html do
      head do
        titile "My Page"
      end
      body do
        button "btn btn-primary" do
          "Click me"
        end
      end
    end
  }

  eg1_out=%{
    <html>
      <head>
        <title>My Page</title>
      </head>
      <body>
        <button class="btn btn-primary">Click me</button>
      </body>
    </html>
  }.green

  eg2_in=%{
2:
    div("panel panel-lg", css:"color:green"){
      span{"Hello World"}
    }
  }

  eg2_out=%{
    <div class="panel panel-lg", style="color:green">
      <span>Hello World</span>
    </div>
  }.green

  puts eg1_in
  puts "=>\n" + eg1_out
  puts
  puts eg2_in
  puts "=>\n" + eg2_out

end

def print_logo
  puts "**************************\n* Welcome to Slight REPL *".green
  puts "**************************".green
  puts "\\h for help.\n\n".green
end

main
