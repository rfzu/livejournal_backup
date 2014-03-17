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
      text_url = URI(@page.uri).path[1..-1]
      @page.save text_url
      later_page = @page.link_with(:text => "Previous Entry").nil? ? @page.link_with(:text => "Previous") : @page.link_with(:text => "Previous Entry")
      break if later_page.nil?
      @page = later_page.click
    end
  end
  
end

tech = Lj_bckp.new
tech.lj_save