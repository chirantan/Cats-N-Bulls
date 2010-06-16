require 'monkey_patching'
require 'words'
require 'alphabets'
require 'test/unit'

class Dictionary
	
  WORDS = File.open('words', 'r').read.strip.split(' ')
	TEXT = ' ' + WORDS.join(' ')
  
  def self.find(collection, given_options = {})
		options = {
			:containing_any => [],
			:containing_all => [],
			:not_containing => [],
			:not_in_same_places_as => ''
    }.update(given_options)
		
		matches = WORDS
		
		if !options[:containing_any].empty?
			containing_any = options[:containing_any]
			matches = 
			matches.collect do |word|
				word.include_any? containing_any
			end.compact!
		end
		
		if !options[:containing_all].empty?
			containing_all = options[:containing_all]
			matches = 
			matches.collect do |word|
				word.include_all? containing_all
			end.compact!
		end
		
		if !options[:not_containing].empty?
			not_containing = options[:not_containing]
			matches = 
			matches.collect do |word|
				word if !word.include_any?(not_containing)
			end.compact!
		end
		
		return case collection
			when :first then matches.first
			when :all then matches
			when :count then matches.size
		end
		
  end
	
	def self.occurence_count(alphabet)
		alphabet = Alphabet.new(alphabet.upcase)
		alphabet.occurences.size
	end

	def self.occurence_hash
		occurences = {}
		Word::LETTERS.each do |letter|
			occurences.store(letter, occurence_count(letter))
		end
		occurences
	end
end

