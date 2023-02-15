require 'crypto'
require 'spec_helper'

describe Solver do

let(:test_solver) { Solver.new }
# let(:test_feed) { Document.new(test_solver.get_feed('http://threadbender.com/rss.xml')) }
let(:test_feed) { REXML::Document.new(File.open('./data/test.xml')) }
let(:test_root) { test_feed.root }

subject {test_solver}

  it { should res