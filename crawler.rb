# encoding: utf-8

require 'nokogiri'
require 'open-uri'

user = ARGV[0]
base_url = "http://forum.rpg2000.4players.de/phpBB3/"
url = "#{base_url}search.php?terms=all&author=#{URI::encode(user)}"

page = Nokogiri::HTML(open(url))
results = []
  
if page.search("[text()*='Es wurden keine passenden Ergebnisse gefunden.']").empty?
  has_next = true
  i = 0
  while has_next
    puts i += 1
    page.search("td.postbody").each do |post_preview|
      # messy structure !
      link = post_preview.parent.parent.parent.parent.previous.search('td')[1].search('td div')[0].search('a').attribute('href').value
      link = link[2..-1] # remove "./"
      post_page_link, post_anchor = link.split("#")
      post_page = Nokogiri::HTML(open("#{base_url}#{post_page_link}"))
      anchor_point = post_page.search("a[name='#{post_anchor}']")
      unless anchor_point.empty?
        # messy structure again
        results << anchor_point[0].parent.parent.parent.search('div.postbody')[0].to_s
      end
    end

    next_nav = page.search("div.nav a[text()*='Nächste']")
    has_next = !next_nav.empty?
    if has_next
      next_link = next_nav[0].attribute('href').value
      page = Nokogiri::HTML(open("#{base_url}#{next_link}"))
    end
  end
  puts "Beiträge für User #{user}"
  puts results.join("\n\n")
else
  puts "User unbekannt: #{user}"
end
