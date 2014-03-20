require 'rubygems'
require 'mechanize'

class Lj_bckp

  def initialize(login ="login", password = "")
    @login = login
    @password = password
    @lp = Mechanize.new
    @url = "http://#{@login}.livejournal.com/latest"
    @page = @lp.get @url
    Dir.mkdir(login) unless File.exist?(login)
    Dir.chdir(login)
  end

  def lj_login
  end

  def lj_save

    index = File.open('index.html', 'w' )
    index.puts "<HTML>
      <HEAD>
      <TITLE>livejournal x</TITLE>
      </HEAD>
      <BODY>
      Backup of #{@login}'s livejournal
      <br>"

    loop do
      text_url = URI(@page.uri).path[1..-1]
      @page.save text_url
      index.puts "<a href=#{text_url}>#{text_url}</a>
        <br>"
      later_page = @page.link_with(:text => "Previous Entry").nil? ? @page.link_with(:text => "Previous") : @page.link_with(:text => "Previous Entry")
      break if later_page.nil?
      @page = later_page.click
    end

    index.puts '</BODY>
      </HTML>'
    index.close
  end
  
end

tech = Lj_bckp.new
tech.lj_save