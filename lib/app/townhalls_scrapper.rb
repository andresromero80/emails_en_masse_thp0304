require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'pry'

class ScrappingManager

    attr_accessor :url_obj, :array_info, :data

    def initialize
      @url_obj = " "
      @array_info = []

    end 

    def get_the_email_of_a_townhal_from_its_webpage (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	list = page.xpath('//tr/td')
    	list_string = list.to_s	
    	addrs = list_string.upcase.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/)
    	addrs.map! { | email | email.downcase }

    	return addrs
    end 
    	
    def get_all_the_urls_of_val_doise_townhalls (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	a_urls = Array.new

    	list = page.xpath('//a[@class = "lientxt"]')

    	list.each do | link |
            a_urls << "http://annuaire-des-mairies.com#{link['href'][1..-1]}"
        end

    	return a_urls
    end 

    def get_all_names (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	a_names = Array.new
    	list = page.xpath('//a[@class = "lientxt"]')

    	list.each do |name|
            a_names << name.to_s.match(/>(.+)</)[1]
        end

    	return a_names
    end 


    def get_all_the_emails (array)
    	liste_emails = Array.new
    	array.length.times do | i |
            begin
                puts "Scrapping #{i}/#{array.length} emails de #{@url_obj.split("/")[-1]}..."
                get_the_email_of_a_townhal_from_its_webpage(array[i])
        		liste_emails[i] = get_the_email_of_a_townhal_from_its_webpage(array[i])
                system("clear")
            rescue StandardError => e #error opening the URL
                liste_emails[i] = nil
                puts e.class
                puts e.message
            end
        end

    	return liste_emails.flatten
    end 

    #Method that creates a hash ville => email
    def create_list(urlstring)
        @url_obj = urlstring
        villes = self.get_all_names(@url_obj)
        urls = self.get_all_the_urls_of_val_doise_townhalls(@url_obj)
        emails = self.get_all_the_emails(urls)
        dep = @url_obj.split("/")[-1]
        nom_dep = dep.split(".")[0].capitalize

        villes.length.times do |i| 
            @array_info << [villes[i], emails[i], nom_dep]
        end 

        return @array_info
    end 

    def run(url)
        data = create_list(url)

        return data
    end
end