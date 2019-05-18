class NumberWord < ApplicationRecord

def letter_combinations(digits)
    #return if number not valid
    return [] if digits.blank? || digits.length != 10 || digits.split('').select{|a|(a.to_i == 0 || a.to_i == 1)}.length > 0
    #number to letters mapping
    letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}

    # Read dictionary file and hold all values in a array
    dictionary = []
    file_path = Rails.root.join("db","dictionary.txt")
    File.foreach( file_path ) do |word|
      dictionary.push word.chop.to_s.downcase
    end
    # get all letters for numbers in form of array
    keys = digits.chars.map{|digit|letters[digit]}

    results = {}
    total_number = keys.length - 1 # total numbers
    #Loo through all letters and get matching records with dictionary
    for i in (2..total_number)
      first_array = keys[0..i]
      second_array = keys[i + 1..total_number]
      next if first_array.length < 3 || second_array.length < 3
      first_combination = first_array.shift.product(*first_array).map(&:join) # Get product of arrays
      next if first_combination.blank?
      second_combination = second_array.shift.product(*second_array).map(&:join)
      next if second_combination.blank?
      results[i] = [(first_combination & dictionary), (second_combination & dictionary)] # get common values from arrays
    end
    #arrange words like we need as a output
    final_words = []
    results.each do |key, combinataions|
      next if combinataions.first.blank? || combinataions.last.blank?
      combinataions.first.product(combinataions.last).each do |combo_words|
        final_words << combo_words
      end
    end
    # for all numbers
    final_words << (keys.shift.product(*keys).map(&:join) & dictionary).join(", ") # matche with all character
    final_words
  end

end
