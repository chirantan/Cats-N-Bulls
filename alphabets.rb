class Alphabet
	
	ALL = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split ''
	VOWELS = 'AEIOU'.split ''
	
	def initialize name
		@name = name
	end
	
	def vowel?
		VOWELS.include?(@name)
	end
	
	def occurence_count
		occurences.size
	end
	
	def occurences
		Dictionary::TEXT.scan(/[ \t](#{@name}...)/).flatten | 
		Dictionary::TEXT.scan(/[ \t](.#{@name}..)/).flatten | 
		Dictionary::TEXT.scan(/[ \t](..#{@name}.)/).flatten |
		Dictionary::TEXT.scan(/[ \t](...#{@name})/).flatten
	end
	
	def weight
	end
	
end