require 'slight/config'
require 'slight/filter'
require 'slight/engine'

class PrettyRender < Filter
  def self.do(src_data); end
end

class PrettyOutput < Filter
end

conf = Slight::Configuration.new do |c|
  c.use PrettyRender
  c.use PrettyOutput, :after
  #c.set :pretty_html, true
end

custom_engine = Slight::Engine.new(conf)

begin
  raise IOError, "source file was not given." if ARGV.length == 0
  src_file = ARGV[0]
  STDOUT.puts custom_engine.render(File.new(src_file).read)
rescue DSLException => errs
  STDERR.puts "Source File Issue: #{src_file}"
  STDERR.puts errs.message
  STDERR.puts [errs.inspect, errs.backtrace.join("\n")].join("\n")
  exit 1
rescue Exception => errs2
  STDERR.puts errs2.message
  STDERR.puts [errs2.inspect, errs2.backtrace.join("\n")].join("\n")
  exit 1
end

exit 0



