# Stacked - A Ruby wrapper for the Stack Exchange API (v1.0)

# Note: This code is being actively developed and will be merged with master when ready.

While a lot of the core code has remained unchanged, this fork has went through many updates to get it working with the latest version (1.0) of the Stack Exchange API. Many thanks to radar for this initial work on this project.

## Installation

    # Currently installs outdated version of the gem
    # sudo gem install stacked

## Usage

Stacked is configurable to work with any of the Stack Exchange sites. When setting up the client, just specify the site you wish to access, the API version number, and your api key. By default, Stacked will access Stack Overflow API version 1.0. Note: You must still supply your own api key in the config.

    # Access Stack Overflow API v1.0
    Stacked::Client.configure do |config|
      config.api_key = 'yourapikey'
    end
    
    # Access Server Fault API v1.0
    Stacked::Client.configure do |config|
      config.site    = 'serverfault.com',
      config.version = '1.0',
      config.api_key = 'yourapikey'
    end

Methods that are designed to take options in the API are designed that way in the wrapper also, as you'd expect. For more details, read the Stack Overflow API [documentation](http://api.stackoverflow.com/1.0/help).

    require 'stacked'
    
    # - - Questions / Answers / Comments
    
    # Setup the client
    Stacked::Client.configure do |config|
      config.api_key = 'yourapikey' # required
    end
    
    # Returns 30 (default page size) questions based on activity (default sort option)
    Stacked::Question.all
    
    # Returns questions tagged with 'ruby', including the question body and comments
    Stacked::Question.all(:tagged => 'ruby', :body => true, :comments => true)
    
    # Returns a individual question by id
    question = Stacked::Question.find(151338)
    
    # Returns paged answers for the question
    answers = question.answers
    
    # Returns paged comments for the question
    comments = question.comments
    
    # You can also specify multiple ids as an array for all find requests
    questions = Stacked::Question.find([151338, 4579074])
    
    # Returns paged questions based on search criteria
    Stacked::Question.search(:intitle => 'github', :tagged => 'ruby')
    
    # - - Users

    # Returns the specified user
    skeet = Stacked::User.find(22656)
    
    # Returns all badges awarded to the user
    skeet.badges
     
## Documentation

For additional details, checkout the latest generated [documentation](http://raid5.github.com/stacked).
