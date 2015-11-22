require 'open-uri'
require 'net/http'
require 'json'
require 'csv'
require './api_helper'

coinsecrets_base_url = 'http://api.coinsecrets.org/block/'
toshi_base_url = 'https://bitcoin.toshi.io/api/v0/blocks/'

num_of_weeks = 10
num_of_blocks = 6*24*7*num_of_weeks
# num_of_blocks = 100
toshi_latest = ApiCaller.new(toshi_base_url+'latest',true).data
end_block = 382797
# end_block = JSON.parse(toshi_latest)["height"]


start_block = end_block - num_of_blocks + 1
file_name = "results_#{start_block}_#{end_block}"

# f = File.open(file_name+'.txt','a+')
p "This should take #{num_of_blocks/3600} hours. Writing to #{file_name}"

def order_hash_by_array(hash,keys_array)
	hbar = {}
	keys_array.each do |key|
		hbar[key] =hash[key]
	end
	return hbar
end

CSV.open('results/'+file_name+'.csv',"wb",col_sep: ",") do |csv|
	# csv << ["block","time","data"]
	headers = (1..50).to_a.map{|e| 'ph_'+e}
	(start_block..end_block).to_a.reverse.map do |b|
		breakdown, result = {},[]
		url = coinsecrets_base_url+b.to_s
		data = ApiCaller.new(url,false).data
		response = JSON.parse(data)
		op_returns=response['op_returns']		
		return unless op_returns
		protocols = op_returns.map{|o| o['protocols']}
		protocol_names = protocols.map{|p| p.first['name'] if p.count>0}
		breakdown = protocol_names.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
		breakdown.keys.each do |k,v| 
			breakdown['unknown'] = breakdown.delete(k) unless k 
		end
		num_new_keys = breakdown.keys.count
		headers += breakdown.keys
		headers = headers.uniq
		ordered_breakdown = order_hash_by_array(breakdown,headers)
		result = [b,Time.at(response['timestamp'].to_i).strftime "%Y-%m-%d %H:%M"]+ordered_breakdown.map{|e| e.last}
		p result
		csv << result
		sleep 1
		File.write('results/'+file_name+'_headers.txt',["block","time"]+headers)
	end
	csv << ["block","time"]+headers	
end

