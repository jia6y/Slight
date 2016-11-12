$:.unshift File.expand_path('../../lib', __FILE__)
require 'slight/dsl'

module Slight
  class DSL
    def run
        doctype :html
        html do
          head do
            title "Example"
            use "/css/bootstrap.css"
            use "/script/jquery.js"
            use "/script/angular.js"
          end
          body do
            div "panel" do
              nav "nav nav-pill", id:"NavMenu", css:"color: red" do
                img! src:"/images/icon1.png"
              end
            end
            br
            hr
          end
        end
    end
  end
end

Slight::DSL.new(STDOUT).run
