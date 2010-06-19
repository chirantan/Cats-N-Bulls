require 'alphabet'

class Word

  attr_accessor :value, :cats, :bulls
  attr_reader :occurence_weight

  GAME_WORD_LENGTH = 4
  STARTING = 'IDEA'
  
  def initialize(word)
    raise "Word has to be of length #{GAME_WORD_LENGTH}" if word.nil? || word.length != GAME_WORD_LENGTH
    @value = word
    @cats = @bulls = nil
    @occurence_weight = calculate_occurence_weight
  end
  
  def similar_words(options)
    options = {
      :cats => @cats,
      :bulls => @bulls,
      :order => :most_likely,
      :direction => :desc
    }.update(options)
    Dictionary.find(:all, options)
  end

  # => Not used right now. But will be used when the program will be choosing
  # => the word and user will be guessing.
  def match(word)
    return cats_with(word), bulls_with(word)
  end
  
  def letters
    @value.to_s.split('')
  end
  
  def cats_with(word)
    raise "word to be matched for cats has to be on class Word. Given word was #{word}" unless word.instance_of? Word
    (self.letters & word.letters).size - bulls_with(word)
  end
  
  def bulls_with(word)
    raise "word to be matched for bulls has to be on class Word. Given word was #{word}" unless word.instance_of? Word
    bull = 0
    own_letters = letters
    word_letters = word.letters
    for i in 0...GAME_WORD_LENGTH
      bull += 1 if own_letters[i] == word_letters[i]
    end
    bull
  end
  
  def alphabets
    letters.collect do |letter|
      Alphabet.new(letter)
    end
  end

  def includes_any?(vals)
    vals.empty? || vals.any? {|val| @value.include?(val)}
  end

  def includes_all?(vals)
    vals.empty? || !vals.collect {|val| @value.include?(val)}.include?(false)
  end

  def include?(letter)
    @value.include? letter
  end

  def better_than?(word)
    return true if !word || self == word || (@cats == 0  && @bulls == 0)
    (@cats > word.cats && @bulls >= word.bulls) || @bulls > word.bulls
  end

  class << self
    def find_by_value(value)
      Dictionary::WORDS.each do |word|
        return word if word.value == value
      end
    end
  end

  private

    def calculate_occurence_weight
    alphabets.collect(&:occurence_count).inject do |occerence_count, result|
      result += occerence_count
    end
  end

end

require 'dictionary'