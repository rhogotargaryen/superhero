require "bundler/setup"
require_relative "../bin/environment"
class Selector
    attr_accessor :name
    def initialize(name)
        @name = name
    end
    def check_marvel
        doc = Nokogiri::HTML(open("http://superheroes.wikia.com/wiki/List_of_Marvel_Characters"))
    end
end

