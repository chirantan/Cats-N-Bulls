require 'word'
require 'dictionary'

class CatsNBulls

  def initialize
    @used_words = []
    @excluded_letters = []
    @candidate_words = Dictionary::WORDS
  end
  
  def start
    @used_words << Word.new(Word::STARTING)
    suggest_current_word
  end
  
  def current_word
    @used_words.last
  end

  def last_word
    @used_words[@used_words.size - 2]
  end
  
  def suggest_current_word
    fail unless current_word
    p current_word.value
    response = gets.chomp
    cats, bulls = response.split(' ').collect(&:to_i)
    if bulls == Word::GAME_WORD_LENGTH
      puts "DONE. Your word is #{current_word.value}." and exit
    else
      current_word.cats = cats
      current_word.bulls = bulls
      @excluded_letters = @excluded_letters | current_word.letters.uniq if cats == 0 && bulls == 0
      next_word
    end
  end
  
  def next_word
    if current_word.better_than?(last_word)
      @candidate_words = current_word.similar_words(
          :not_containing => @excluded_letters,
          :candidate_words => @candidate_words
        ) - @used_words
    else
      p 'Not better than the last word eh?'
      @candidate_words.delete(current_word)
      @used_words.delete(current_word)
    end
    @used_words << @candidate_words.first
    suggest_current_word
  end

  def find_in_used_words(cats, bulls)
    @used_words.collect {|used_word| used_word if used_word.cats == cats && used_word.bulls == bulls }.compact
  end

  private

  def fail
    p "Your word is invalid! Or may be I'm not good enough to guess it. No, probably its the former is true."
    exit
  end
end



