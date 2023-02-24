require 'crypto'
require 'spec_helper'

describe Solver do

let(:test_solver) { Solver.new }
# let(:test_feed) { Document.new(test_solver.get_feed('http://threadbender.com/rss.xml')) }
let(:test_feed) { REXML::Document.new(File.open('./data/test.xml')) }
let(:test_root) { test_feed.root }

subject {test_solver}

  it { should respond_to(:puzzle_list, :calculations, :let_list, :dicts, :name_dict, :pop_dict, :dict_1k)}

  it "should read the XML stream items" do
    test_root.each_element('//item') { |item|
      desc = item.delete_element('description').to_s
    }
  end

  it "should break up the Puzzles" do
    test_solver.puzzle_list.clear
    x = test_solver.puzzle_list.length
    test_solver.puzzle_list = test_solver.conform_puzzles(test_root)
    y = test_solver.puzzle_list.length
    x.should < y
  end

  it "should have a 4 dictionaries" do
    test_solver.pop_dict[6].values.length.should be > 1100
    test_solver.dicts[6].values.length.should be > 1100
    test_solver.name_dict[6].values.length.should be > 100
    test_solver.dict_1k[6].values.length.should be > 20
  end

  it "should create A list of puzzle objects" do
    test_solver.puzzle_list = test_solver.conform_puzzles(test_root)
    test_solver.puzzle_list[0].should be_an_instance_of(Puzzle)
  end

  it "should create puzzle objects with Crypto/Author/Date attribs" do
    test_solver.puzzle_list = test_solver.conform_puzzles(test_root)
    test_solver.puzzle_list[0].publ_date.should be_true
    test_solver.puzzle_list[0].author.should be_true
    test_solver.puzzle_list[0].crypto.should be_true
  end

  it 'should split the string at the /[.?!]"* - / point' do
    a, b = test_solver.seperate_author("UWDC W FXWYFC! WII IREC RA W FXWYFC. UXC QWY LXB MBCA EVZUXCAU RA MCYCZWIIH UXC BYC LXB RA LRIIRYM UB TB WYT TWZC. - TWIC FWZYCMRC")
    a.should eq("UWDC W FXWYFC WII IREC RA W FXWYFC UXC QWY LXB MBCA EVZUXCAU RA MCYCZWIIH UXC BYC LXB RA LRIIRYM UB TB WYT TWZC".downcase)
    b.should eq("TWIC FWZYCMRC".downcase)
    #also converts to downcase for puzzle... UPCASE reserved for solved letters
  end

  it "should start a puzzle by splitting and sorting words" do
    test_solver.puzzle_list = test_solver.get_puzzles()
    puzz = test_solver.puzzle_list[1]
    puzz.crypto_broken.length.should be > 0
    puzz.crypto_broken[0].length.should < puzz.crypto_broken[-1].length
    puzz.crypto_broken[1].length.should < puzz.crypto_broken[-2].length
    puzz.crypto_broken[2].length.should <= puzz.crypto_broken[3].length
    puzz.crypto_broken[3].length.should <= puzz.crypto_broken[4].length
  end

  it "should return letter objects from the let_list hash" do
    test_solver.set_letters([*('a'..'z')].join)
    test_solver.let_list['g'].should be_kind_of(Letter)
    test_solver.let_list['g'].should respond_to(:name, :possible)
  end

  it "should be able to switch a dictionary for a word" do
    subject.set_letters(subject.puzzle_list[5].full_uniques)
    solver_test_word = subject.puzzle_list[5].crypto_broken[-1]
    solver_test_word = Word.new(solver_test_word, subject.dicts)

    stw_pos_len = solver_test_word.possibles.length
    solver_test_word.possibles = subject.try_dictionary(solver_test_word, subject.name_dict)
    stw_pos_len.should_not eq(solver_test_word.possibles.length)

    solver_test_word.possibles = subject.try_dictionary(solver_test_word, subject.pop_dict)
    stw_pos_len.should_not eq(solver_test_word.possibles.length)
  end

end

