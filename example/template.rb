require 'slight/config'
require 'slight/prep'

class PrettyPrep < Prep
  def scan(src_data)

  end
end

class SimplePrep < Prep
end

configure do |c|
  c.use PrettyPrep
  c.use SimplePrep, '>'
end

