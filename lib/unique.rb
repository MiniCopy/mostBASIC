require 'radix'
require 'base64'

module Unique

  def unique_ify(word)
    if word.length < 2 then return word end
    u = ''
    word.each_char { |c|
    next if u.include? c
      u << c
    }
    return u
  end

  def pattern_create(string)
    s = strin