require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    alphabet = ('A'..'Z').to_a * 10
    @letters = alphabet.sample(10)
  end

  def score
    answer = params[:answer].upcase!
    word_serialized = URI.parse("https://dictionary.lewagon.com/#{answer}").read
    @parsed_word = JSON.parse(word_serialized)
    @grid = params[:grid].chars
    @result = ""
    @answer_chars = answer.chars
    check_valid = @answer_chars.each do |char|
      if @grid.include?(char)
        @grid.delete(char)
        @result = "success"
      else
        return session[:result] = "Sorry but #{answer} can't be built out of #{@grid}"
      end
    end

    if check_valid && @parsed_word["found"] == true
      session[:result] = "Congratulations #{answer} is a valid ENGLISH word !"
    else
      session[:result] = "Sorry but #{answer} doesn't seem to be an ENGLISH word !"
    end

  end

  #   if

  #   elsif

  #   end

end
