require "bundler/setup"


class Super
    attr_reader :name, :gen_info, :studio
    PATH = "http://superheroes.wikia.com/wiki"
    PARAMS = { marvel: "/List_of_Marvel_Characters", dc: "/List_of_DC_Characters"}
    def initialize(name)
        @name = name.downcase.titleize!
        @studio = self.studio_check
        return @name = false if @studio == nil
        @gen_info = self.gen_info
    end
    
    def self.lister(stud)
        curr_list = []
        doc = Nokogiri::HTML(open("#{PATH}#{PARAMS[stud]}")).css("#mw-content-text li a")
        doc.each {|x| curr_list << x.text}
        no_info = doc.map {|x| x.text if x.attr("href").include?("?") == true}
        no_info.delete(nil)
        curr_list.reject! {|x| no_info.include? x}
        return curr_list
    end
    
    def self.dc_lister
        self.lister(:dc)
    end
    
    def self.m_lister
        self.lister(:marvel)
    end

    @@m_list = Super.m_lister - ["U.S. Agent", "A-Bomb", "Patriot", "Radioactive Man", "Payback", "Hercules", "Gladiator", "Death", "Assassin", "X-23", "Nuke", "Dracula"]
    @@dc_list = Super.dc_lister - ["Oracle", "Scarecrow", "Shark King"]

    def self.m_list
        @@m_list
    end
    
    def self.dc_list
        @@dc_list
    end

    def studio_check
        i = 0
        while i < 2
            if @@m_list.include?(@name)
                return @studio = "Marvel"
            elsif @@dc_list.include?(@name)
                return @studio = "DC"
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
    
    def gen_info
        s_param = @name.gsub(" ", "_")
        doc = Nokogiri::HTML(open("#{PATH}/#{s_param}")).css("#mw-content-text p")
        @gen_info = doc.text.delete("\n")
    end
end

