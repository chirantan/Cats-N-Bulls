require 'monkey_patching'
require 'word'
require 'alphabet'
require 'test/unit'

class Dictionary
  
  WORDS = File.open('words', 'r').read.strip.split(' ').compact
  TEXT = ' ' + WORDS.join(' ')
  
  def self.find(collection, given_options = {})
    options = {
      :containing_any => [],
      :containing_all => [],
      :not_containing => [],
      :cats => nil,
      :bulls => nil,
      :with => nil,
      :order => nil,
      :direction => :asc
    }.update(given_options)
    
    matches = WORDS

    if !options[:containing_any].empty?
      containing_any = options[:containing_any]
      matches = 
        matches.collect do |match|
        match.includes_any(containing_any)
      end.compact!
    end
    
    if !options[:containing_all].empty?
      containing_all = options[:containing_all]
      matches = 
        matches.collect do |match|
        match.includes_all(containing_all)
      end.compact!
    end
    
    if !options[:not_containing].empty?
      not_containing = options[:not_containing]
      matches = 
        matches.collect do |match|
        match if !match.includes_any(not_containing)
      end.compact!
    end

    if options[:cats] && options[:with]
      cats  = options[:cats]
      cat_match = Word.new(options[:with])
      matches = 
      matches.collect do |match|
        match if Word.new(match).cats_with(cat_match) == cats
      end.compact!
    end

    if options[:bulls] && options[:with]
      bulls  = options[:bulls]
      bull_match = Word.new(options[:with])
      matches =
        matches.collect do |match|
        match if Word.new(match).bulls_with(bull_match) == bulls
      end.compact!
    end

    if options[:order]
      matches =
      case options[:order]
      when :alpha
        matches.sort
      when :most_likely
        matches.sort {|m1, m2| occurence_weight(m1) <=>  occurence_weight(m2)}
      end
    end

    if options[:direction] == :desc
      matches = matches.reverse
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

  def self.occurence_weight(word)
    Word.new(word).occurence_weight
  end
end