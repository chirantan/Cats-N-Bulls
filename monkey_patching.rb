class Array
  def randomly_pick
    Word.new(self[rand(self.length)])
  end

  def sum
    inject {|num, result| result += num }
  end
end

class String
    
end

