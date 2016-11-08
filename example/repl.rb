$:.unshift File.expand_path('../../lib', __FILE__)

require 'slight'
@default_engine = Slight::Engine.new

Signal.trap("INT") do
  puts "*** Exit now ***".light_blue
  puts "Terminating...".light_blue
  exit 1
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
  puts " \\q       => exit".green
  puts " \\v       => show version (also: \\ver, \\version)".green
  puts
end

def print_logo
  puts "**************************\n* Welcome to Slight REPL *".green
  puts "**************************".green
  puts "\\h for help.\n\n".green
end

print_logo

buff = ""
loop do
  print "sl: "
  case line = STDIN.readline.sub(/[\n\r]/,'')
  when "\\h"
    print_help
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
