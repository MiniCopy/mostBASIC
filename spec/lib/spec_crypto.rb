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
    te