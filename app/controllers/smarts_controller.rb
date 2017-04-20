
require 'nokogiri'
require 'open-uri'
require 'openssl'

class SmartsController < ApplicationController
	def search
	  @value = params[:search]	
	  @arr = Array.new()

	  #get the HTML from the website
	  if(@value == nil)
		#do nothing
	  else 	
	    #get contents		
		uri  = URI("http://tratu.soha.vn/dict/en_vn/" + @value)
		body = Net::HTTP.get(uri)				
				
		#get images					
	 	uri_img = URI.parse("https://www.google.com/search?site=&tbm=isch&source=hp&biw=1301&bih=654&q="+@value.to_s+"&oq="+@value.to_s+"&gs_l=img.3..0l10.3980.5814.0.6035.7.5.0.2.2.0.82.342.5.5.0....0...1ac.1.64.img..0.7.350.dT986GSEzMA/")
		http = Net::HTTP.new(uri_img.host, uri_img.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE			
		request = Net::HTTP::Get.new(uri_img.request_uri)
		response = http.request(request)	
		body_img = response.body 									
	  end

	  #parse it and use CSS selectors to find all elements in list elements
      #id = #
      #class = .	

      #get images
      html = Nokogiri::HTML(body_img)
	  @images = html.css('a > img')

	  #getcontents
	  html = Nokogiri::HTML(body)		
	  html.css("#show-alter").each do |node|	
		@title = node.css("h2").text
		sections_html = Nokogiri::HTML(node.inner_html)
		sections_html.css("#content-3").each do |node1|						
		  contents_html = Nokogiri::HTML(node1.inner_html)
		  contents_html.css("#content-5").each do |node2|
			@h5 = node2.css("h5").text					
			@arr.push(@h5)					
		  end					
		end			
	  end

	end
end
