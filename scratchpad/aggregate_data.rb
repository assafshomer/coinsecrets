require 'json'
require 'csv'
require '../helpers/arrays_helper'
require '../helpers/headers_helper'

include HeadersHelper
include ArraysHelper

data_path = '/home/assaf/ruby_projects/coinsecrets/data/data.tsv'
aggr_path = '/home/assaf/ruby_projects/coinsecrets/data/aggr_data.tsv'
sum_path = '/home/assaf/ruby_projects/coinsecrets/data/data_with_sum.tsv'
cum_path = '/home/assaf/ruby_projects/coinsecrets/data/data_with_cum.tsv'

data = CSV.read(data_path,col_sep: "\t")
aggr_data = group_by_days(data)
summed_data = group_by_days(data,{sum: true})
cummed_data = group_by_days(data,{sum: true, cum: true})

CSV.open(aggr_path,"wb",col_sep: "\t") do |csv|
	aggr_data.each do |row|
		csv << row
	end
end

CSV.open(sum_path,"wb",col_sep: "\t") do |csv|
	summed_data.each do |row|
		csv << row
	end
end

CSV.open(cum_path,"wb",col_sep: "\t") do |csv|
	cummed_data.each do |row|
		csv << row
	end
end