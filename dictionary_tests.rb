require 'dictionary'

class DictionaryTests < Test::Unit::TestCase
	def test_find_containing_all
		assert_equal ['ABED', 'BADE', 'BEAD'], Dictionary.find(:all, :containing_all => ['A', 'B', 'E', 'D'])
	end
	
	def test_find_containing_any
		assert_equal Alphabet.new('A').occurences.size, Dictionary.find(:count, :containing_any => ['A'])
	end
	
	def test_find_not_containing
		matches = Dictionary.find(:all, :not_containing => ['A'])
		matches.each do |match|
			assert_equal false, match.include?('A')
		end
	end
end