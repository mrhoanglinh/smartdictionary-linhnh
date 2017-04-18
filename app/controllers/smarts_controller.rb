require 'nokogiri'

require 'open-uri'
require 'rubygems'
require 'mechanize'
require 'openssl'


class SmartsController < ApplicationController
	def search
		@value = params[:search]	
		@arr = Array.new()

		@agent = Mechanize.new

		# get the HTML from the website
		if(@value == nil)
			# do nothing
		else 
			uri  = URI("http://tratu.soha.vn/dict/en_vn/" + @value)
			body = Net::HTTP.get(uri)

			url_img = "https://www.google.com/search?site=&tbm=isch&source=hp&biw=1290&bih=634&q=" + @value.to_s + "&oq=" + @value.to_s + "&gs_l=img.3..35i39k1j0l"
			@page_img = @agent.get url_img
			binding.pry
			# #bodyImage = Net::HTTP.get(uriImage)
			# binding.pry
			# htmlImage = Nokogiri::HTML(open(uriImage))
			
			# label.css('#rg_s img').each { |l| l.attr('src') }
		end

		# parse it and use CSS selectors to find all elements in list elements
	    #id = #
	    #class = .
	    
	    #@image = htmlImage.css('a > img')
	    

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

		
		

		# html.css("#content-2").each do |node|
		# 	@title1 = node.css("h2").text
		# 	sections_html = Nokogiri::HTML(node.inner_html)
		# 	sections_html.css("#content-3").each do |node1|				
		# 		contents_html = Nokogiri::HTML(node1.inner_html)
		# 		contents_html.css("#content-5").each do |node2|
		# 			@h51 = node2.css("h5").text
		# 			@arr1.push(@h51)
		# 		end					
		# 	end			
		# end
	end
end
