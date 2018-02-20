require "bundler/setup"

require_relative "../bin/environment"
class Selector
    attr_accessor :name
    def initialize(name)
        @name = name
    end
    def self.m_lister
        @@m_list = []
        doc = Nokogiri::HTML(open("http://superheroes.wikia.com/wiki/List_of_Marvel_Characters")).css("#mw-content-text li a")
        doc.each {|x| @@m_list << x.text}
        return @@m_list
    end
    def self.dc_lister
        @@dc_list = []
        doc = Nokogiri::HTML(open("http://superheroes.wikia.com/wiki/List_of_DC_Characters")).css("#mw-content-text li a")
        doc.each {|x| @@dc_list << x.text}
        return @@dc_list
    end
    

    @@m_list = Selector.m_lister
    @@dc_list = Selector.dc_lister

    def self.m_list
        @@m_list
    end
    def self.dc_list
        @@dc_list
    end
    
end

