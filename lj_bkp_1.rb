require 'rubygems'
require 'mechanize'

class Lj_bckp

  def initialize(login ="borisakunin", password = "")
    @login = login
    @password = password
  end

  def lj_login
	end

	def lj_save
    lp = Mechanize.new
    url = "http://#{@login}.livejournal.com/latest"
    page = lp.get url

    loop do
      #page.save 'class_.html'
      text_url = page.uri.to_s.scan(%r{com/(.*)}).join
      page.save text_url
      #p text_url
      later_page = page.link_with(:text => "Previous Entry")
      #text = page.links.each {|link| puts link.text }
      #p text.join
      p later_page
      break if later_page.nil?
      #p later_page
      page = page.link_with(:text => "Previous Entry").click
      #page.save 'class_.html'
      #page.links.each {|link| puts link.text }
	  end

  end

end

tech = Lj_bckp.new
tech.lj_save

#наверху красивый класс, внизу грязные эксперименты
=begin
 login = "technobastard"
 lp = Mechanize.new
 url = "http://#{login}.livejournal.com/latest"
 page = lp.get url
 #p page
 #page.save 'last1.html'
 #lp.click(upload_page.link_with(:text => /basic Uploader/))

 #page.links.each {|link| puts link.text }
 page =  page.link_with(:text => "Previous").click
 #p old.body
 page.save 'last3.html'
=end
#конец
#new_url = text_url.scan(%r{com/(.*)}).join