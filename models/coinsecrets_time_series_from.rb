require 'open-uri'
require 'net/http'
require 'json'
require 'csv'
require '../helpers/api_helper'
require '../helpers/headers_helper'

coinsecrets_base_url = 'http://api.coinsecrets.org/block/'

start_block = ARGV[0].to_i || 323000 # this is the earlies block coinsecrets provide data for
end_block = start_block+1000000
file_name = "results_#{start_block}"

def order_hash_by_array(hash,keys_array)
	hbar = {}
	keys_array.each do |key|
		hbar[key] =hash[key]
	end
	return hbar
end

CSV.open('results/'+file_name+'.csv',"wb",col_sep: ",") do |csv|
	# csv << ["block","time","data"]
	headers = []
	(start_block..end_block).to_a.map do |b|
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
		headers += breakdown.keys
		headers = headers.uniq
		ordered_breakdown = order_hash_by_array(breakdown,headers)
		result = [b,Time.at(response['timestamp'].to_i)]+ordered_breakdown.map{|e| e.last}
		p result
		csv << result
		sleep 1
		File.write('results/'+file_name+'_headers.txt',["block","time"]+headers)
	end
	csv << ["block","time"]+headers	
end

