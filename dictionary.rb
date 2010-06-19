require 'monkey_patching'
require 'word'
require 'alphabet'
require 'test/unit'

class ThingsWithWords
  class << self
    def fetch_words
      puts 'Warming up... Think of your 4 letter word meanwhile.'
      all_words = File.open('words', 'r').read.strip.split(' ').compact
      all_words.collect do |word|
        Word.new(word) if word.split('').uniq.size == 4
      end.compact.uniq
    end
  end
end

class Dictionary < ThingsWithWords
  
  WORDS = fetch_words
  TEXT = ' ' + WORDS.join(' ')

  class << self
    def find(collection, given_options = {})
      options = {
        :containing_any => [],
        :containing_all => [],
        :not_containing => [],
        :cats => nil,
        :bulls => nil,
        :with => nil,
        :candidate_words => Dictionary::WORDS,
        :order => nil,
        :direction => :asc
      }.update(given_options)

      matches = options[:candidate_words]

      if !options[:containing_any].empty?
        containing_any = options[:containing_any]
        matches =
          matches.collect do |match|
          match if match.includes_any?(containing_any)
        end.compact.uniq
      end

      if !options[:containing_all].empty?
        containing_all = options[:containing_all]
        matches =
          matches.collect do |match|
          match if match.includes_all?(containing_all)
        end.compact.uniq
      end

      if !options[:not_containing].empty?
        not_containing = options[:not_containing]
        matches =
          matches.collect do |match|
          match if !match.includes_any?(not_containing)
        end.compact.uniq
      end

      if options[:cats] && options[:with]
        cats  = options[:cats]
        cat_match = Word.new(options[:with])
        matches =
          matches.collect do |match|
          match if match.cats_with(cat_match) == cats
        end.compact.uniq
      end

      if options[:bulls] && options[:with]
        bulls  = options[:bulls]
        bull_match = Word.new(options[:with])
        matches =
          matches.collect do |match|
          match if match.bulls_with(bull_match) == bulls
        end.compact.uniq
      end

      if options[:order]
        matches =
          case options[:order]
        when :alpha
          matches.uniq.sort_by(&:value)
        when :most_likely
          matches.uniq.sort_by(&:occurence_weight)
        end
      end

      if options[:direction] == :desc
        matches = matches.uniq.reverse
      end

      return case collection
      when :first then matches.first
      when :all then matches
      when :count then matches.size
      end

    end

  end
  
end