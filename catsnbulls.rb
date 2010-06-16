require 'monkey_patching'
require 'words'
require 'dictionary'

class CatsNBulls
  def initialize
    @used_words = []
  end
  
  def start
    @used_words << Word.new(Word::STARTING)
    suggest_current_word
  end
  
  def current_word
    @used_words.last
  end
  
  def suggest_current_word
    puts current_word.word
    response = gets.chomp
    cats, bulls = response.split(' ').collect(&:to_i)
    if bulls == 4
      puts "DONE. Your word is #{current_word.word}." and exit
    else
      current_word.cats = cats
      current_word.bulls = bulls
      next_word
    end
  end
  
  def next_word
  end
end



