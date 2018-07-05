require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  seen_letters = HashMap.new
  number_odds = 0

  string.each_char do |char|
    if seen_letters.get(char) == 'odd'
      seen_letters.set(char, 'even')
    else 
      seen_letters.set(char, 'odd')
    end 
  end 

  seen_letters.each do |key, val|
    if val == 'odd'
      number_odds += 1
    end 
  end 
  return false if number_odds > 1
  true
end
