require 'spec_helper'
require __dir__+'/../helpers/headers_helper.rb'

include HeadersHelper

describe "HeadersHelper" do
	let!(:initial) { (1..10).to_a }
	let!(:keys_1) { %w(foo bar buzz) }
	let!(:step_1) { insert(initial,keys_1) }
	let!(:keys_2) { %w(foo bar quuax fuzz) }
	let!(:step_2) { insert(step_1,keys_2) }
	let!(:keys_3) { %w(foo bar quuax fuzz) }
	let!(:step_3) { insert(step_2,keys_3) }	
	describe 'adding keys_1' do
	  it 'should add them in 1,2,3' do
	  	step_1.should == keys_1 + (4..10).to_a
	  end
	  it 'should add only quuax and fuzz in 4,5' do
	  	step_2.should == ['foo','bar','buzz','quuax','fuzz',6,7,8,9,10]
	  end
	  it 'should not add anything' do
	  	step_3.should == ['foo','bar','buzz','quuax','fuzz',6,7,8,9,10]
	  end	  	  
	end

	describe 'new keys' do
  	let!(:a1) { %w(foo bar buzz blue red green) }
  	let!(:a2) { %w(foo bar quuax fuzz) }		
	  it 'should identify new keys only' do
	  	find_new_keys(a1,a2).should == %w(quuax fuzz)
	  end
	end

	describe 'find first integer spot' do
	  let!(:a) { ['foo','bar',1,2,3] }
	  it 'should find pos 2' do
	  	find_next_position(a).should == 2
	  end
	end

	describe 'placehoders' do
	  let!(:a) { ['foo','bar',1,2,3] }
	  let!(:b) {  ['foo','bar',"1",2,3]}
	  it 'should find placehoders' do
	  	get_placeholders(a).should == [1,2,3]
	  	get_placeholders(b).should == [2,3]
	  end
	end
end