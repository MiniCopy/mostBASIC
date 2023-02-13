class Letter
  #Letter objects that contain their own NAME, and a list of POSSIBLE interpretations
  #It is assumed that by the rules of the cryptogram that they cannot end up being themself
  attr_accessor :name, :possibles

  def initialize(itself="r")
    #Sets the possible list, and the self.name
    #lowercase letters are the unchanged letters, upcase is solved letters
    if itself == "'" || itself == '-'
      @name = itself
      @possibles = Set[itself]
      @possibles.freeze
    else
      @name = itself.downcase
      @possibles = Set.new
      @possibles = %w[ E T A O I N S H R D L C U M W F G Y P B V K J X Q Z ]
      @possibles.delete(itself.upcase)
    end
  end

  def singular?
    @possibles.length == 1
  end
end