require 'crypto'
require 'puzzle'
require 'spec_helper'

describe Puzzle do

  it { should respond_to(:crypto, :crypto_broken, :solution, :author_sol, :author, :publ_date, :solve