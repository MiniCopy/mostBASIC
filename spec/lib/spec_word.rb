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

  it { should respond_to( :name, :uniques, :u_length, :length, :possibles, :pattern_value, :curr