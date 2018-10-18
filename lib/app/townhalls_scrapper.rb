require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'pry'

url_link = "http://www.annuaire-des-mairies.com/vienne.html"

# "http://annuaire-des-mairies.com/val-d-oise.html"

class GetEmails

    def initialize (urlstring)
      @url_obj = urlstring
      @list_hash = Hash.new
    end 

    def get_the_email_of_a_townhal_from_its_webpage (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	list = page.xpath('//tr/td')
    	list_string = list.to_s	
    	addrs = list_string.upcase.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/)
    	addrs.map! {|email| email.downcase}
    	addrs
    end 
    	
    def get_all_the_urls_of_val_doise_townhalls (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	a_urls = Array.new
    	a_names = Array.new
    	array_info = Array.new
    	list = page.xpath('//a[@class = "lientxt"]')
    	list.each{|link| a_urls << "http://annuaire-des-mairies.com#{link['href'][1..-1]}"}  #=> list of 
    	list.each{|name| a_names << name.to_s.match(/>(.+)</)[1]}
    	return a_urls
    end 

    def get_all_names (urlstring)
    	page = Nokogiri::HTML(open(urlstring))
    	a_names = Array.new
    	list = page.xpath('//a[@class = "lientxt"]')
    	list.each{|name| a_names << name.to_s.match(/>(.+)</)[1]}
    	return a_names
    end 


    def get_all_the_emails (array)
    	liste_emails = Array.new
    	array.length.times do |i|
            # puts i
            # p get_the_email_of_a_townhal_from_its_webpage(array[i])
    		liste_emails[i] = get_the_email_of_a_townhal_from_its_webpage(array[i])
            rescue 
                liste_emails[i] = " "
    	end 
    	# array.length.times do |i|
    		p liste_emails.flatten
    	# end 
    end 

    def create_list

      self.get_all_names(@url_obj).zip(self.get_all_the_emails(self.get_all_the_urls_of_val_doise_townhalls(@url_obj))).to_h
    end 

end 

# GetEmails.new(url_link).create_list

binding.pry


