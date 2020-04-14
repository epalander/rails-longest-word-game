class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(rand(26))
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    @english_word = english_word?(word)
    @included = included?(@word, @letters)
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def inside_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter.capitalize) }
  end
end

# def score
#     @word = params[:word]
#     @letters = params[:letters].split
#     @grid_word = inside_grid?(@word, @letters)
#     @english_word = english_word?(@word)
#     @result = result(@word)
#   end


#   private
#   def english_word?(word)
#     response = open(“https://wagon-dictionary.herokuapp.com/#{word}“)
#     json = JSON.parse(response.read)
#     return json[‘found’]
#   end
#   def inside_grid?(word, letters)
#     word.chars.all? { |letter| word.count(letter) <= letters.count(letter.capitalize) }
#   end
#   def result(word)
#     word.size**2
#   end
