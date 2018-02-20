require 'bundler/setup'
require_relative "../bin/environment"

class Super
    attr_accessor :name
    attr_reader :studio
    
    def initialize(sel_obj)
       a = Selector.new(sel_obj.name.downcase!)
       @studio = a.studio_check
       @name = a.name
    end
    
    
end