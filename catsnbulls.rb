require 'monkey_patching'
require 'word'
require 'dictionary'

class CatsNBulls
  def initialize
    @used_words = []
    @exclude_words_with = []
    @candidate_words = Dictionary::WORDS
  end
  
  def start
    @used_words << Word.new(Word::STARTING)
    suggest_current_word
  end
  
  def current_word
    @used_words.last
  end
  
  def suggest_current_word
    p current_word.value
    response = gets.chomp
    cats, bulls = response.split(' ').collect(&:to_i)
    if bulls == 4
      puts "DONE. Your word is #{current_word.value}." and exit
    else
      current_word.cats = cats
      current_word.bulls = bulls
      @exclude_words_with = @exclude_words_with | current_word.letters.uinq if cats == 0 && bulls == 0
      next_word
    end
  end
  
  def next_word
    @candidate_words = (current_word.similar_words(:not_containing => @exclude_words_with) - @used_words) & @candidate_words
    @used_words << @candidate_words.first
    suggest_current_word
  end
end



