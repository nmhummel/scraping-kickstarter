# require libraries/modules here

require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4") 
# title: project.css("h2.bbcard_name strong a").text 
# image link: project.css("div.project-thumbnail a img").attribute("src").value 
# description: project.css("p.bbcard_blurb").text 
# location: project.css("span.location-name").text 
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i 

def create_project_hash
  html = File.read('fixtures/kickstarter.html') # This just opens a file and reads it into a variable
  kickstarter = Nokogiri::HTML(html)
  
  projects = {}
  
  kickstarter.css("li.project.grid_4").each do |project|
    # a loop to iterate through the projects (and also an empty projects hash, which we will fill up with scraped data)   
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {  # we're converting the title into a symbol using the to_sym method
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  # Remember that symbols make better hash keys than string



  projects  # return the projects hash

end

# create_project_hash 



