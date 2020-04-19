require "open-uri"
require "pry-byebug"

class GamesController < ApplicationController

  def new
    v = %w(A E I O U).to_a.sample(rand(1..6))
    v_count = v.count
    c = (('A'..'Z').to_a - v).to_a.sample((10 - v_count))
    @letters = (v + c).shuffle
    # @letters = ('A'..'Z').to_a.sample(rand(26))
  end

  def score
    # binding.pry
    @letters = params[:letter].split
    @word = params[:word].upcase
    @english_word = english_word?(word)
    @included = included?(@word, @letters)
  end

  private

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def inside_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter.capitalize) }
  end

  # def result(word)
  #   word.size**2
  # end
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
