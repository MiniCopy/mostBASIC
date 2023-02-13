
require  './lib/unique'
include Unique
include REXML
include ActionView::Helpers::SanitizeHelper

class Puzzle
  attr_accessor :crypto, :crypto_broken, :solution, :author_solution, :author, :publ_date, :solve_time,
    :uniques, :full_uniques, :letter_list, :author_broken, :full_broken

  def initialize(xml_object)
      date = nil
      @publ_date = Date.parse(xml_object.elements['pubDate'].text)
      @crypto, @author = seperate_author(xml_object.elements['description'].text)
    @uniques = unique_ify(@crypto)
    @full_uniques = unique_ify((@crypto + @author)).delete(" ")
    set_up_puzzle()
  end

  def seperate_author(unbroken)
    #Sets puzzle to unsolved letters (downcase) and removes punctuation
    unbroken.downcase!
    a, b = unbroken.split(/[.?!]"* - /)
    # Special thanks to RUBULAR.com
    # Breaks the puzzle at the Crypto/Author break. Author starts with" -"
    # Sentence ends with punctuation. So "! -", ". -", '?" -' all must be accounted
    a.delete!(".,!?:;&()")
    a.strip!
    b.delete!(".,!?:;&()")
    b.strip!
    return a, b
  end

  def set_up_puzzle()
    #Breaks PUZZ into the crypto array sorted by word size
    @crypto_broken = Set.new
    @crypto_broken += @crypto.split
    hyphens = Array.new
    @crypto_broken.each { |w|
       if w.include? '-' then hyphens += w.split(/-/) end
     }
    @crypto_broken.delete_if { |w|
      w.include? '-'
    }
    @crypto_broken += hyphens
    @crypto_broken = @crypto_broken.each.sort { |a,b|  #Sorts words by size
    unique_ify(a).length <=> unique_ify(b).length
    }

    @author_broken = Array.new
    @author_broken += @author.split
    hyphens = Array.new
    @author_broken.each { |w|
       if w.include? '-' then hyphens += w.split(/-/) end
     }

    @author_broken.delete_if { |w|
      w.include? '-'
    }

    @author_broken += hyphens
    @author_broken = @author_broken.each.sort { |a,b|  #Sorts words by size
    unique_ify(a).length <=> unique_ify(b).length
  }
  end

  def set_solve_time

  end

  def to_s
    print 'Code: ', @crypto,  "\nDate: ", @publ_date, "\nCompleted: ", "\n"
  end
end