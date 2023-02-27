require 'crypto'
require 'puzzle'
require 'spec_helper'

describe Puzzle do

  it { should respond_to(:crypto, :crypto_broken, :solution, :author_sol, :author, :publ_date, :solve_time,
    :uniques, :full_uniques, :let_list, :author_broken, :full_broken)}


  it "should intiate with Crypto/Author/Date" do
    p = Puzzle.new("H TJAHJBJ IOFI VWFMUJK IMVIO FWK VWXLWKHIHLWFA ALBJ SHAA OFBJ IOJ DHWFA SLMK HW MJFAHIN. IOFI HP SON MHZOI, IJUYLMFMHAN KJDJFIJK, HP PIMLWZJM IOFW JBHA IMHVUYOFWI",
    "UFMIHW AVIOJM GHWZ CM",
    Date.parse("Thu, 27 Sep 2012 23:45:00 -0400"))
    p.should be_true
    p.publ_date.should be_true
    p.crypto.should be_true
    p.author.should be_true
  end

  it "should have a list of unique letters" do
    p = Puzzle.new("ABCDDDDDD",
      "DDDEEEEEF",
      Date.parse("Thu, 27 Sep 2012 23:45:00 -0400"))
    p.uniques.should be_true
    p.uniques.should be == "ABCD"
    p.uniques.length.should eq(4)
    p.full_uniques.length.should eq(6)
  end

end

