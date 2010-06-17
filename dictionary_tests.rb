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

  def test_find_cats
    cats_with = 'IDEA'
    cats_with_word = Word.new(cats_with)
    matches = Dictionary.find(:all, :cats => 2, :with => cats_with)
    matches.each do |match|
      assert_equal 2, Word.new(match).cats(cats_with_word)
    end
  end

  def test_find_bulls
    bulls_with = 'IDEA'
    bulls_with_word = Word.new(bulls_with)

    matches = Dictionary.find(:all, :bulls => 2, :with => bulls_with)
    matches.each do |match|
      assert_equal 2, Word.new(match).bulls(bulls_with_word)
    end

    match_count = Dictionary.find(:count, :bulls => 4, :with => bulls_with)
    assert_equal 1, match_count

  end
end