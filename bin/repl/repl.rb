$:.unshift File.expand_path('../../../lib', __FILE__)

require_relative 'utils.rb'
require 'slight'
@default_engine = Slight::Engine.new
@slout = STDOUT

at_exit{
  puts "\n--bye--".light_blue
  @slout.close
}

Signal.trap("INT") do
  puts "Terminating...".light_blue
  puts "*** Exit now ***".light_blue
  exit 1
end

def main
  print_logo
  buff = ""
  loop do
    print "sl:> "
    case line = STDIN.readline.sub(/[\n\r]/,'').strip
    when /^\\/ # build-in commands
      case line
      when "\\h"
        print_help
      when "\\eg"
        print_example
      when "\\q"
        puts "*** Exit now ***".light_blue
        exit 0
      when /\\(v|version|ver)/
        puts "ver #{Slight::VERSION}\n\n"
      else
        puts "Invalid command. type \\h for help.".red
      end
    when /^@/
      if buff.size == 0 then
        fn = line.sub('@','')
        puts "LOAD PATH=\"#{fn}\"".light_blue
        sl_handler(fn, is_file=true)
        buff.clear
        puts ""
      else
        buff << line << "\n"
      end
    when /^>@/
      fn = line.split('@')[1] || ""
      case fn.strip
      when "off"
        unless @slout == STDOUT
          puts "spool turned off".light_blue
          @slout.close
          @slout = STDOUT
        else
          puts "spool was alread turned off".red
        end
      when ""
        puts "spool turned off. output path not set.".red
      else
        unless @slout == STDOUT then
          puts "spool was alread turned on".red
        else
          puts "spool turned on".light_blue
          puts "OUTPUT PATH=\"#{fn}\"".light_blue
          @slout = File.open(fn, 'w+')
        end
      end
    when ";"
      if buff.size > 0 then
        sl_handler(buff)
        buff.clear
        @slout.flush #if @slout == STDOUT
        puts ""
      end
    else
      buff << line << "\n"
    end
  end
end

def sl_handler(buff, is_file=false)
  if is_file
    output = @default_engine.render(buff)
  else
    output = @default_engine.render("console",buff)
  end

  if @slout == STDOUT
    @slout.puts output.green
  else
    @slout.puts output
  end
rescue Exception => err
  errno = err.message.split(":")[1].to_i - 1
  buff.split("\n").each_with_index do |line, i|
    if i == errno then
      puts "=>#{i+1} #{line}".red
    else
      puts "  #{i+1} #{line}".yellow
    end
  end
  puts ""
  STDERR.puts err.message.red
  #STDERR.puts [err.inspect, err.backtrace.join("\n")].join("\n")
end

def print_help
  puts " @file    => load and compile file dynamically. E.g. @/tmp/page.slight".green
  puts " >@       => set output. E.g. Open: >@/tmp/output. Turn off: >@off".green
  puts " \\eg      => example".green
  puts " \\q       => exit".green
  puts " \\v       => show version (also: \\ver, \\version)".green
  puts
end

def print_example
  eg1_in=%{
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
