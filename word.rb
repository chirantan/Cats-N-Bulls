class Word
  attr_accessor :value
  
  STARTING = 'IDEA'
  
  def initialize(word)
    raise 'word has to be of length 4' if word.nil? || word.length != 4
    @value = word
  end
  
  def similar_words(cats = 1, bulls = 0)
    
  end
  
  def match(word)
    return cats(word), bulls(word)
  end
  
  def letters
    @value.to_s.split('')
  end
  
  def cats(word)
    raise "word to be matched for cats has to be on class Word. Given word was #{word}" unless word.instance_of? Word
    (self.letters & word.letters).size - bulls(word)
  end
  
  def bulls(word)
    raise "word to be matched for bulls has to be on class Word. Given word was #{word}" unless word.instance_of? Word
    bull = 0
    for i in 0...self.letters.size
      bull += 1 if self.letters[i] == word.letters[i]
    end
    bull
  end
  
  def alphabets
    alphabets = []
    letters.each do |letter|
      alphabets <<	Alphabet.new(letter)
    end
    alphabets
  end
  
end

