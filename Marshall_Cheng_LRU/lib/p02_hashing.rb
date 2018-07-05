require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    fixnum = 0
    self.each_with_index do |el, idx|
      el = el.ord if el.is_a?(String)
      el = el.hash if el.is_a?(Array)
      fixnum += (el + idx).hash
    end
    fixnum
  end 
  
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  def hash
    self.values.sort.to_a.hash
  end
end
