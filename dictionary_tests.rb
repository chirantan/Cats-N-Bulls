require 'dictionary'

class DictionaryTests < Test::Unit::TestCase
  def test_find_containing_all
    matches = Dictionary.find(:all, :containing_all => ['A', 'B', 'E', 'D'])
    matches.each do |word|
      assert_equal true, word.include?('A')
      assert_equal true, word.include?('B')
      assert_equal true, word.include?('E')
      assert_equal true, word.include?('D')
    end
  end

  def test_find_containing_any
    matches = Dictionary.find(:all, :containing_any => ['A'])
    rest_of_the_words = Dictionary::WORDS - matches
    matches.each do |word|
      assert_equal true, word.include?('A')
    end
    rest_of_the_words.each do |word|
      assert_equal false, word.include?('A')
    end
  end

  def test_find_not_containing
    matches = Dictionary.find(:all, :not_containing => ['A'])
    matches.each do |word|
      assert_equal false, word.include?('A')
    end
  end

  def test_find_cats
    cats_with = 'IDEA'
    cats_with_word = Word.new(cats_with)
    matches = Dictionary.find(:all, :cats => 2, :with => cats_with)
    matches.each do |word|
      assert_equal 2, word.cats_with(cats_with_word)
    end
  end

  def test_find_bulls
    bulls_with = 'IDEA'
    bulls_with_word = Word.new(bulls_with)

    matches = Dictionary.find(:all, :bulls => 2, :with => bulls_with)
    matches.each do |word|
      assert_equal 2, word.bulls_with(bulls_with_word)
    end

    match_count = Dictionary.find(:count, :bulls => 4, :with => bulls_with)
    assert_equal 1, match_count

  end

  def test_find_word
    @acme = Dictionary.find_word('ACME')
    assert_equal @acme.value, 'ACME'
  end
end