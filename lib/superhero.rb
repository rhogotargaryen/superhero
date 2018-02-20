require 'bundler/setup'
require_relative "../bin/environment"

class Super
    attr_accessor :name
    attr_reader :studio, :path
    
    def initialize(sel_obj)
       a = Selector.new(sel_obj.name.downcase!)
       @studio = a.studio_check
       @name = a.name
       binding.pry
       @path = "#{Selector.path}/List_of_#{@studio}_Characters"
    end
    
end