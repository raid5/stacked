# Stacked - A Ruby wrapper for the Stack Overflow API (v0.5)

This library is built around the Stack Overflow (private) API [described here][http://blog.stackoverflow.com/2010/03/stack-overflow-api-private-beta-starts/]. I am under the impression that it covers all the API methods described in [this comprehensive listing][http://dev.meta.stackoverflow.com/questions/34594/overall-api-method-list], but equally aware that this is a first draft and I am likely to make a mistake or four.

## Installation

To install stacked:

    sudo gem install stacked

To use it:

    require 'stacked'
    Stacked::Question.all
    
To report breakages: http://github.com/radar/stacked/issues.

## Some notes

Methods that are designed to take options in the API are designed that way in the wrapper also, as you'd expect. Take for example +Stacked::Question.all+ which you can pass any options you wish:

     Stacked::Question.all(:pagesize => 10)

In this example the amount of questions returned is limited to 10. 

Other options include:

* page - Specify the page when paginating through a collection.
* body - Set this to true to return the body of the objects you're receiving. By default set to false for questions and answers.
* comments - Set this to true to include the comments in the objects you're receiving.
* fromdate - An integer timestamp of the time you wish to search from (default: 30 days ago, 90 days for reputation).
* todate - An integer timestamp of the time you wish to search to (default: now)
* tagged - A list of tags to scope this find by. Effective only on question methods.

There may be some options I have missed from this list. This is why it's a first draft. So you can tell me I'm missing options, then I can add them and make it a second draft. And so on.

     