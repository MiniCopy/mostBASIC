require 'unique'
require 'spec_helper'
include Unique

describe Unique do 

	Test_U_Word = Struct.new(:name, :length, :u_length, :uniques, :pattern)
	x = "tasty"
	let(:test_u_word) { Test_U_Word.new(x, x.length, 4, "tasy", nil)}
	subject { test_u_word }

	it  { should respond_to(:name, :length, :u_length, :uniques, :pattern)}
	
	it "should convert a string to a set of uniques" do
		unique_ify("tasty").should eq(test_u_word.uniques)
	end

	it "should be able to create patterns" do
		test_u_word.pattern = pattern_create(test_u_word.name)
		test_u_word.pattern.should eq(pattern_create("barbi"))
		pattern_match?("abc", "abb").should be_false
		pattern_match?("aaron", "bblzn").should be_true
		pattern_match?("lincoln", "Lincoln").should be_false
		pattern_match?("lincoln", "pincopn").should be_true
	end

end