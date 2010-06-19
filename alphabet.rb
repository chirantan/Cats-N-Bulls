class Alphabet

  attr_reader :occurence_count
	
  ALL = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split ''
  VOWELS = 'AEIOU'.split ''
  OCCURENCES = {"A" => 1596, "B" => 450, "C" => 505, "D" => 679, "E" => 1466, "F" => 329, "G" => 482, "H" => 522, "I" => 1049, "J" => 105, "K" => 539, "L" => 836, "M" => 558, "N" => 790, "O" => 1196, "P" => 583, "Q" => 20, "R" => 975, "S" => 1429, "T" => 862, "U" => 762, "V" => 181, "W" => 400, "X" => 75, "Y" => 537, "Z" => 98}
	
  def initialize name
    @name = name.upcase
    @occurence_count = occurences
  end
	
  def vowel?
    VOWELS.include?(@name)
  end
  
  def occurences
    OCCURENCES[@name]
  end
	
  def weight
  end

end
