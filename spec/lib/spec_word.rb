require 'word'
require 'unique'
require 'spec_helper'
include Unique

describe Word do

		let(:test_hash) {{
		"CANALBOAT" => unique_ify("CANALBOAT").length,
		"CANALISED" => unique_ify("CANALISED").length,
		"CANALISES" => unique_ify("CANALISES").length,
		"CANALIZED" => unique_ify("CANALIZED").length,
		"CANALIZES" => unique_ify("CANALIZES").length,
		"CANAVERAL" => unique_ify("CANAVERAL").length,
		"CANCELATE" => unique_ify("CANCELATE").length,
		"CANCELING" => unique_ify("CANCELING").length,
		"CANCELOUS" => unique_ify("CANCELOUS").length,
		"CANCEROUS"	=> unique_ify("CANCEROUS").length,
		"CANDAHARS"	=> unique_ify("CANDAHARS").length,
		"CANDIDACY"	=> unique_ify("CANDIDACY").length,
		"CANDIDATE"	=> unique_ify("CANDIDATE").length}
		}

		let(:test_dict) { ["Test Dictionary"] + Array.new(8) << test_hash }
		let(:test_word) { Word.new("testaword", test_dict)}

  subject {test_word}

  it { should respond_to( :name, :uniques, :u_length, :length, :possibles, :pattern_value, :current_dict)}

  it "should be able to get a list of possible words from a dictionary" do
  	test_word.find_possibles(test_dict).should eq(%w[CANCELOUS CANCEROUS])  	
  	test_word.possibles.each { |p|
  		test_word.u_length.should eql(unique_ify(p).length)
  		test_word.pattern_value.should eql(pattern_create(p))
  	  }
  end	

  its (:length) { should eq(9)}
  its (:u_length) { should eq(8)}
  its (:pattern_value) { should eq(pattern_create("CANCELOUS"))}
	its (:which_dictionary?) { eq("Test Dictionary")  }

	it "should respond with a string containing the Dictionary name, from which_dictionary?" do
  	expect(subject.which_dictionary?).to be_an_instance_of(String)
  end

end