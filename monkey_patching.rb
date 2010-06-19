class Array
  def sum
    inject {|num, result| result += num }
  end
end


