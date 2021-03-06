require 'open-uri'
require 'net/http'
require 'json'
require 'csv'
require '../helpers/api_helper'
require '../helpers/arrays_helper'
require '../helpers/headers_helper'
require 'fileutils'
include HeadersHelper
include ArraysHelper


p 10.times.each_slice(2)

# path = '/home/assaf/ruby_projects/coinsecrets/data/processing/headers.txt'
# p File.read(path).to_a



# path = '/home/assaf/ruby_projects/coinsecrets/data/processing/clean_headers.txt'
# # path = '/home/assaf/ruby_projects/coinsecrets/data/379905_384799/clean_headers.txt'
# p CSV.read(path,col_sep: "\t").flatten

# data = [['a',1,2,3],['a',2,3,4],['b',3,3,3]]
# cats = ['a','b']
# foo_by_category(data,categories,{sum: true, com: true}).should == [[3,5,7,15,15],[3,3,3,9,24]]

# data_path = '/home/assaf/ruby_projects/coinsecrets/data/data.tsv'
# aggreagted_path = '/home/assaf/ruby_projects/coinsecrets/data/agg_data.tsv'

# data = CSV.read(data_path,col_sep: "\t")

# data_nested_array = group_by_days(data)

# CSV.open(aggreagted_path,"wb",col_sep: "\t") do |csv|
# 	# csv << ["Protocol","Transactions"]
# 	data_nested_array.each do |row|
# 		csv << row
# 	end
# end

# path = '/home/assaf/ruby_projects/coinsecrets/data/agg_data_with_sum.tsv'
# data = CSV.read(path,col_sep: "\t")

# p data.first.count
# p data[1].count



# a = ['foo','bar',1,2,3]
# b = a.select{|x| x.is_a?(Integer)}
# p a.index(b.first)


# o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
# string = (0...50).map { o[rand(o.length)] }.join

# p string





# csv_data=CSV.read('coinsecrets.csv');
# csv_data.each{|l| l.shift};
# headers = ["block", "time", "Factom", "unknown", "Ascribe", "Open Assets", "Proof of Existence", "Monegraph", "Eternity Wall", "BlockSign", "Colu", "Omni Layer", "Stampery", "Remembr", "Bitproof", "Blockstore", "CoinSpark", "stampd"]
# CSV.open('coinsecrets.tsv',"wb",col_sep: ",") do |csv|
# 	csv << headers
# 	csv_data.each do |row|
# 		csv << row
# 	end
# end


# p __dir__

# p CSV.read('/home/assaf/ruby_projects/coinsecrets/results_383644_383648.csv')

# h={foo: 1, bar: 2, buzz: 3}
# a=[:foo, :buzz, :bar]
# hbar = {}
# a.each do |key|
# 	hbar[key] =h[key]
# end
# p h
# p hbar
# def call_api(url)
# 	Net::HTTP.get(URI(url))		
# end
# turl = 'https://bitcoin.toshi.io/api/v0/blocks/latest'

# # csurl = 'http://api.coinsecrets.org/block/353197'
# data = ApiCaller.new(turl,true).data
# json = JSON.parse(data)
# p json["height"]
# p json['transactions_count']



# p call_api('https://bitcoin.toshi.io/api/v0/blocks/326785')

# a= [[{"name"=>"Ascribe", "url"=>"https://www.ascribe.io/"}], [], [], [], [{"name"=>"CoinSpark", "display"=>"COINSPARK TRANSFERS\nGenesis block index: 327080\n Genesis txn offset: 56920\nGenesis txid prefix: 108F\n    Asset reference: 327080-56920-36624\n              Input: 0\n             Output: 0\n     Qty per output: 900\n\nGenesis block index: 327094\n Genesis txn offset: 11085\nGenesis txid prefix: 2856\n    Asset reference: 327094-11085-22056\n              Input: 0\n             Output: 0\n     Qty per output: 900\n\nGenesis block index: 327211\n Genesis txn offset: 65847\nGenesis txid prefix: 0DE4\n    Asset reference: 327211-65847-58381\n              Input: 0\n             Output: 0\n     Qty per output: 90\nEND COINSPARK TRANSFERS\n\n", "url"=>"http://coinspark.org/developers/"}]]

# p a.count

# names = a.map{|p| p.first['name'] if p.count>0}

# p names.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }

# # arr = ['aa','aa','bb','bb','cc']

# # p arr.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }

# a= {"Ascribe"=>353, "Factom"=>962, "Proof of Existence"=>43, nil=>2789, "Open Assets"=>857, "Colu"=>520, "Bitproof"=>4, "Monegraph"=>278, "CoinSpark"=>10, "Eternity Wall"=>276, "Stampery"=>83, "Blockstore"=>261, "Omni Layer"=>20, "Remembr"=>1, "BlockSign"=>1, "foo"=>2}

# b={"foo": 1, "bar": 2}

# a.keys.each { |k,v| a['unknown'] = a.delete(k) unless k }

# result = {"foo" =>1}


# a.each{|k,v| if result[k] then result[k] += v.to_i else result[k] = v.to_i end }

# p result

# path = '/home/assaf/ruby_projects/coinsecrets/data/data_384790_384791_data.csv'
# # f= File.open(path,'a+')
# # g = File.open(path+'_1','a+')
# # content = File.read(path)
# # p "content #{content}"
# # g << "foo\n"
# # g << content

# File.open(path).each do |line|
# 	line = line.gsub('"',"")
# end


# require 'json'
# require 'csv'
# json_path = 'results_326785_383233.json'
# csv_path = 'results_326785_383233.csv'
# # h = File.read(path)
# # p h.to_json
# # json = JSON.parse(h.to_json)

# h = {"max_block"=>383233, "Monegraph"=>14642, "Factom"=>13929, "Ascribe"=>11492, "unknown"=>107909, "min_block"=>326785, "Eternity Wall"=>1232, "Open Assets"=>64962, "Blockstore"=>40629, "Proof of Existence"=>1552, "CoinSpark"=>26313, "Stampery"=>1647, "Omni Layer"=>225, "Colu"=>4651, "Bitproof"=>646, "BlockSign"=>651, "Remembr"=>21, "stampd"=>237, "Crypto Copyright"=>1, "LaPreuve"=>15, "OriginalMy"=>126, "ProveBit"=>56}

# data_nested_array = h.sort

# CSV.open(csv_path,"wb",col_sep: ",") do |csv|
# 	csv << ["Protocol","Transactions"]
# 	data_nested_array.each do |row|
# 		csv << row
# 	end
# end

# File.write(path,h.to_json)