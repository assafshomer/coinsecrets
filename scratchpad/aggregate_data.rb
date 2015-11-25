require 'json'
require 'csv'
require '../helpers/arrays_helper'
require '../helpers/headers_helper'

include HeadersHelper
include ArraysHelper

data_path = '/home/assaf/ruby_projects/coinsecrets/data/data.tsv'
aggreagted_path = '/home/assaf/ruby_projects/coinsecrets/data/agg_data.tsv'

data = CSV.read(data_path,col_sep: "\t")

data_nested_array = group_by_days(data)

CSV.open(aggreagted_path,"wb",col_sep: "\t") do |csv|
	# csv << ["Protocol","Transactions"]
	data_nested_array.each do |row|
		csv << row
	end
end