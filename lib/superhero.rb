require 'bundler/setup'
require_relative "../bin/environment"

class Super
    attr_accessor :name
    attr_reader :studio, :gen_info
    
    def initialize(sel_obj)
       @studio = sel_obj.studio_check
       @name = sel_obj.name
       @gen_info = sel_obj.gen_info
    end
    
end