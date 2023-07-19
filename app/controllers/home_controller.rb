class HomeController < ApplicationController
  def index
  end

  def about
    
    @about_me = "I'm a Full Stack Web Development student at Red River College, 
    currently in my third term.  
    Right now,,I'm diving into frameworks like Ruby on Rails.
    I really enjoy coding and. leaning new things, 
    building something from scratch is  incredibly fun and cool. 
    I hope someday I can develop applications to solve real-world problems."
   

  end

end