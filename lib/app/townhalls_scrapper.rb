require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'pry'

#url_link = "http://www.annuaire-des-mairies.com/vienne.html"

class ScrappingManager

    attr_accessor :url_obj, :array_info, :data

    def initialize ()
      @url_obj = " "
      @array_info = []

    end 

    def get_the_email_of_a_townhal_from_its_webpage (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	list = page.xpath('//tr/td')
    	list_string = list.to_s	
    	addrs = list_string.upcase.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/)
    	addrs.map! { |email| email.downcase }

    	return addrs
    end 
    	
    def get_all_the_urls_of_val_doise_townhalls (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	a_urls = Array.new

    	list = page.xpath('//a[@class = "lientxt"]')

        compteur = 0
    	list.each do |link|
            a_urls << "http://annuaire-des-mairies.com#{link['href'][1..-1]}"  #=> list of
            compteur +=1
            break if compteur >= 10
        end
    	# list.each{|name| a_names << name.to_s.match(/>(.+)</)[1]}
    	return a_urls
    end 

    def get_all_names (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	a_names = Array.new
    	list = page.xpath('//a[@class = "lientxt"]')
        compteur = 0

    	list.each do |name|
            a_names << name.to_s.match(/>(.+)</)[1]
            compteur +=1
            break if compteur >= 10
        end

    	return a_names
    end 


    def get_all_the_emails (array)
    	liste_emails = Array.new
    	array.length.times do |i|
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
    	# array.length.times do |i|
    	return liste_emails.flatten
    	# end 
    end 

    #Method that creates a hash ville => email
    def create_list(urlstring)
        @url_obj = urlstring
        villes = self.get_all_names(@url_obj)
        emails = self.get_all_the_emails(self.get_all_the_urls_of_val_doise_townhalls(@url_obj))
        dep = @url_obj.split("/")[-1]
        nom_dep = dep.split(".")[0].capitalize

        villes.length.times do |i| 
            @array_info << [villes[i], emails[i], nom_dep]
        end 

        return @array_info
    end 

    def run
        #Scrapping du département de la Manche
        # email_list.push(create_list("http://www.annuaire-des-mairies.com/manche.html"))
        # email_list.push(create_list("http://www.annuaire-des-mairies.com/manche-2.html"))
        # email_list.push(create_list("http://www.annuaire-des-mairies.com/manche-3.html"))

        #Scrapping du département de la Vienne
        # email_list.push(create_list("http://www.annuaire-des-mairies.com/vienne.html"))

        #Scrapping du département de l'Ille-et-Vilaine
        # email_list.push(create_list("http://www.annuaire-des-mairies.com/ille-et-vilaine.html"))
        # email_list.push(create_list("http://www.annuaire-des-mairies.com/ille-et-vilaine-2.html"))

        (create_list("http://www.annuaire-des-mairies.com/ille-et-vilaine-2.html"))

        #### Create JSON file
        # File.open("email.json","w") do |f|
  #         f.write(email_list.flatten(1).to_json)
  #         end 

  return @array_info
end

end 

# GetEmails.new(url_link).create_list

# binding.pry


