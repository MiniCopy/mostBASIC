
class Word
  attr_accessor :name, :uniques, :u_length, :length, :possibles, :pattern_value, :current_dict

  def initialize(name="test", dictionary)
    @name = name
    @uniques = unique_ify(name)
    @length = @name.length
    @u_length = @uniques.length
    @pattern_value = pattern_create(name)
    @current_dict = dictionary
    @possibles = dictionary.find_possible_matches(self)
  end

  def which_dictionary?
    @current_dict.name
  end

  def has_possibilities?
    @possibles.length > 0
  end

  def reload_possibles(dictionary)
    @possibles = dictionary.find_possible_matches(self)
    @current_dict = dictionary
  end

end