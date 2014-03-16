require 'rubygems'
require 'mechanize'

class Lj_bckp

  def initialize(login ="technobastard", password = "")
    @login = login
    @password = password
    @lp = Mechanize.new
    @url = "http://#{@login}.livejournal.com/latest"
    @page = @lp.get @url
  end

  def lj_login
  end

  def lj_save
    loop do
      text_url = @page.uri.to_s.scan(%r{com/(.*)}).join
      @page.save text_url
      later_page = @page.link_with(:text => "Previous Entry") 
      later_page ||= @page.link_with(:text => "Previous")
      p later_page
      break if later_page.nil?
      @page = later_page.click
    end
  end
  
end

tech = Lj_bckp.new
tech.lj_savep