require 'spec_helper'
require __dir__+'/../helpers/arrays_helper.rb'
require 'csv'
include ArraysHelper

describe "ArraysHelper" do
  let(:csv_data_path) { 'spec/fixtures/test_data.tsv' }
  let(:days_path) { 'spec/fixtures/test_days.tsv' }	  
  let(:csv_data) { CSV.read(csv_data_path,col_sep: "\t") }
  let(:days) { CSV.read(days_path,col_sep: "\t") }
	describe 'group by first element' do
		let!(:data) { [['a',1,2,3],['a',2,3,4],['b',3,3,3]] }
		let(:categories) { ['a','b'] }
		describe 'get_categories' do
		  it 'should give a b' do
		  	get_categories(data).should == categories
		  end
		  it 'ignore headers in CSV' do
		  	get_categories(days,csv: true).should == ['2015-10-21','2015-10-20','2015-10-19']
		  end
		end
		describe 'aggregation' do
		  it 'aggregate by category' do
		  	aggregate_by_category(data,categories).should == [[[1, 2, 3], [2, 3, 4]], [[3, 3, 3]]]
		  end
		end
		describe 'summing by category' do
		  it 'should sum each category and add the category name' do
		  	sum_by_category(data,categories).should == [[3,5,7],[3,3,3]]
		  end
		  it 'should add the sum' do
		  	sum_by_category(data,categories,{sum: true}).should == [[3,5,7,15],[3,3,3,9]]
		  end
		  it 'should add the commulate' do
		  	sum_by_category(data,categories,{sum: true, cum: true}).should == [[3,5,7,15,24],[3,3,3,9,15]]		  	
		  end
		end
		describe 'group_by_first_element' do
		  it 'should sum elements grouped by first item of each' do
		  	group_by_first_element(data).should == [['a',3,5,7],['b',3,3,3]]
		  end	  
		  it 'should add the sum' do
		  	group_by_first_element(data,{sum: true}).should == [['a',3,5,7,15],['b',3,3,3,9]]
		  end		  
		end	  
	end

	describe 'zooming out from hourse to days' do  
	  it 'should convert time to days only' do
	  	zoom_out_to_days(csv_data).should == days
	  end
	end

	# describe 'insert total' do
	# 	let!(:nosum) { [['a',3,5,7],['b',3,3,3]] }
	# 	it 'should add the sum category' do
	#   	insert_total(nosum).should == [['a',3,5,7,15],['b',3,3,3,9]]
	# 	end
	# end

	describe 'grouping by days' do
	  let(:expected_path) { 'spec/fixtures/test_sum.tsv' }
	  let(:expected) { CSV.read(expected_path,col_sep: "\t") }
	  it 'should convert time to days only' do
	  	group_by_days(csv_data).should == expected
	  end
	end

	describe 'grouping by days with total' do
	  let(:total_path) { 'spec/fixtures/test_total.tsv' }
	  let(:total) { CSV.read(total_path,col_sep: "\t") }
	  it 'should convert time to days only' do
	  	group_by_days(csv_data,{sum: true}).should == total
	  end
	end
	describe 'grouping by days with commulate' do
	  let(:cummulate_path) { 'spec/fixtures/test_cummulate.tsv' }
	  let(:cummulate) { CSV.read(cummulate_path,col_sep: "\t") }
	  it 'should convert time to days only' do
	  	group_by_days(csv_data,{sum: true, cum: true}).should == cummulate
	  end
	end	
	describe 'vector_sum' do
	  let!(:a) { [[1,2,3],[4,5,6]] }
	  it 'shoud sum as vectors' do
	  	vector_sum(a).should == [5,7,9]
	  end
	end


end