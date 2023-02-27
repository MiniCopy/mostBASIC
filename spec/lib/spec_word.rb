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
		"CANALIZES" => unique_ify("CAN