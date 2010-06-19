require 'alphabet'

class Word
  attr_accessor :value, :cats, :bulls
  attr_reader :occurence_weight
  
  STARTING = 'IDEA'
  
  def initialize(word)
    raise 'word has to be of length 4' if word.nil? || word.length != 4
    @value = word
    @cats = nil
    @bulls = nil
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

  def match(word)
    return cats(word), bulls(word)
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
    for i in 0...self.letters.size
      bull += 1 if self.letters[i] == word.letters[i]
    end
    bull
  end
  
  def alphabets
    letters.collect do |letter|
      Alphabet.new(letter)
    end
  end

  def calculate_occurence_weight
    alphabets.collect(&:occurence_count).sum
  end

  def includes_any?(vals)
    return true if vals.empty? || vals.any? {|val| @value.include?(val)}
  end

  def includes_all?(vals)
    return true if vals.empty? || !vals.collect {|val| @value.include?(val)}.include?(false)
  end

  def include?(letter)
    @value.include? letter
  end

  def better_than?(word)
    @cats >= word.cats && @bulls >= word.bulls || @bulls >= word.bulls
  end
  
end


