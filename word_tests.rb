require 'dictionary'

require 'test/unit'

class WordTest < Test::Unit::TestCase
  def setup
    @word = Word.new('ACME')
  end

  def test_occurence_weight
    occurence_weight = Alphabet::OCCURENCES['A'] + Alphabet::OCCURENCES['C'] + Alphabet::OCCURENCES['M'] + Alphabet::OCCURENCES['E']
    assert_equal occurence_weight, @word.occurence_weight
  end

  def test_cats_with
    assert_equal 0, @word.cats_with(Word.find_by_value('ACME'))
    assert_equal 0, @word.cats_with(Word.find_by_value('ACHE'))
    assert_equal 1, @word.cats_with(Word.find_by_value('ACER'))
    assert_equal 2, @word.cats_with(Word.find_by_value('IDEA'))
  end

  def test_bulls_with
    assert_equal 4, @word.bulls_with(Word.find_by_value('ACME'))
    assert_equal 3, @word.bulls_with(Word.find_by_value('ACHE'))
    assert_equal 2, @word.bulls_with(Word.find_by_value('ACER'))
    assert_equal 0, @word.bulls_with(Word.find_by_value('IDEA'))
  end

  def test_include_methods
    assert_equal true, @word.includes_any?([])
    assert_equal false, @word.includes_any?(['K', 'L'])
    assert_equal true, @word.includes_any?(['K', 'L', 'M'])
    assert_equal true, @word.includes_any?(['A', 'C', 'M'])
    assert_equal true, @word.includes_any?(['A', 'C', 'M', 'E'])
    
    assert_equal true, @word.includes_all?([])
    assert_equal false, @word.includes_all?(['K', 'L'])
    assert_equal false, @word.includes_all?(['K', 'L', 'M'])
    assert_equal true, @word.includes_all?(['A', 'C', 'M'])
    assert_equal true, @word.includes_all?(['A', 'C', 'M', 'E'])
    assert_equal false, @word.includes_all?(['A', 'C', 'M', 'E', 'L'])
  end

  def test_better_than
    @word.cats = 2
    @word.bulls = 1
    @idea = Word.find_by_value('IDEA')
    @idea.cats = 0
    @idea.bulls = 0
    assert_equal true, @idea.better_than?(@word)
    @idea.cats = 1
    @idea.bulls = 1
    assert_equal false, @idea.better_than?(@word)
    @idea.cats = 0
    @idea.bulls = 2
    assert_equal true, @idea.better_than?(@word)
    @idea.cats = 3
    @idea.bulls = 1
    assert_equal true, @idea.better_than?(@word)
    @idea.cats = 3
    @idea.bulls = 0
    assert_equal false, @idea.better_than?(@word)
  end

end