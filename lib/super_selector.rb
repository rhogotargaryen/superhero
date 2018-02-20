require "bundler/setup"
require_relative "../bin/environment"

class Selector
    attr_reader :name
    @@path = "http://superheroes.wikia.com/wiki"
    def initialize(name)
        @name = name.downcase.titleize
    end
    
    def self.m_lister
        @@m_list = []
        doc = Nokogiri::HTML(open("#{@@path}/List_of_Marvel_Characters")).css("#mw-content-text li a")
        doc.each {|x| @@m_list << x.text}
        return @@m_list
    end
    
    def self.dc_lister
        @@dc_list = []
        doc = Nokogiri::HTML(open("#{@@path}/List_of_DC_Characters")).css("#mw-content-text li a")
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

    def path
        @@path
    end
        

    def studio_check
        i = 0
        while i < 2
            if @@m_list.include?(@name)
                puts "Marvel character"
                return "Marvel"
            elsif @@dc_list.include?(@name)
                puts "DC character"
                return "DC"
            else
                if @name.include?("The ")
                    @name.gsub!("The ", "")
                    i += 1
                else
                    @name = "The " + @name
                    i += 1
                end
            end
        end
    end
    
    def get_info
        self.studio_check
        s_param = @name.gsub(" ", "_")
        doc = Nokogiri::HTML(open("#{@@path}/#{s_param}")).css("#mw-content-text")
        binding.pry
    end
end

