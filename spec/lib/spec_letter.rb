
require 'letter'
require 'spec_helper'
require 'factory_girl'

FactoryGirl.find_definitions

describe Letter do

  let(:lett) { Letter.new("r")}
  it { should respond_to(:name, :possible)}

  it "should not have itself in possible list" do
    lett.possible.should_not include(lett.name.upcase)
  end
end