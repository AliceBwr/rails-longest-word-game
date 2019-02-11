ActionDispatch::Session::CacheStore
require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    shuffle
  end

  def score
    guess = params[:guess]
    word(guess)
    @serve
  end

  def shuffle
   @letters = []
   10.times { @letters << ('A'..'z').to_a.sample }
  end

  def word(guess)
    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    serialized = open(url).read
    word = JSON.parse(serialized)
    @response = word["found"]
    if @response == false
      @serve = "Sorry, that word doesn't exist!"
      raise
    elsif @response == true
      @serve = "Congrats!"
    elsif @response.split
    end
  end
end
