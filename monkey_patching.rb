class Array
  def randomly_pick
    Word.new(self[rand(self.length)])
  end
end

class String
  def includes_any(vals)
    return self if vals.empty?
    return self if vals.any? {|val| include?(val)}
  end
  
  def includes_all(vals)
    return self if vals.empty?
    return self if !vals.collect {|val| include?(val)}.include?(false)
  end
  
  def doesnt_include?(vals)
    
  end
  
end

