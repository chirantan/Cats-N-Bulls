class Word
  attr_accessor :word, :cats, :bulls
	
	STARTING = 'IDEA'
	
  def initialize(word)
    @word = word
    @cats = 0
    @bulls = 0
  end
  
  def similar_words(cats = 1, bulls = 0)
    
  end
  
  def match(word)
    cats = cats(word)
    bulls = bulls(word)
  end
  
  def letters
    @word.split
  end
  
  def cats(word)
    (self.letters & word.letters).size - bulls
  end
  
  def bulls(word)
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

