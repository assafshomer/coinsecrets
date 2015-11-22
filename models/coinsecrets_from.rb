require 'open-uri'
require 'net/http'
require 'json'
require 'csv'
require __dir__+'/../helpers/api_helper'
require __dir__+'/../helpers/headers_helper'
require 'tempfile'
require 'byebug'

include HeadersHelper

coinsecrets_base_url = 'http://api.coinsecrets.org/block/'
toshi_base_url = 'https://bitcoin.toshi.io/api/v0/blocks/'
toshi_latest = ApiCaller.new(toshi_base_url+'latest',true).data

end_block = ARGV[0].to_i || JSON.parse(toshi_latest)["height"]

num_of_blocks = ARGV[1].to_i || 6*24*365 

start_block = end_block - num_of_blocks

headers = ["date"]+(1..30).to_a

file_name = "data_#{start_block}_#{end_block}"
file_dir = 'data/'

def order_hash_by_array(hash,keys_array)
	hbar = {}
	keys_array.each do |key|
		hbar[key] =hash[key]
	end
	return hbar
end

data_path = file_dir+file_name+'.csv'
headers_path = file_dir+file_name+'_headers.txt'
clean_headers_path = file_dir+file_name+'_clean_headers.txt'
result_path = file_dir+file_name+'_result.csv'
views_path = __dir__+'/../views/data/data.tsv'

CSV.open(data_path,"wb",col_sep: "\t") do |csv|	
	(start_block..end_block).to_a.reverse.map do |b|
		breakdown, result, op_returns = {},[], nil
		url = coinsecrets_base_url+b.to_s
		data = ApiCaller.new(url,false).data
		response = JSON.parse(data)
		op_returns=response['op_returns']		
		unless (op_returns.nil? || op_returns.empty?)
			protocols = op_returns.map{|o| o['protocols']}
			protocol_names = protocols.map{|p| p.first['name'] if p.count>0}
			breakdown = protocol_names.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
			breakdown.keys.each do |k,v| 
				breakdown['unknown'] = breakdown.delete(k) unless k 
			end
			headers = insert(headers,breakdown.keys)
			ordered_breakdown = order_hash_by_array(breakdown,headers)
			timestamp = Time.at(response['timestamp'].to_i).strftime "%Y-%m-%d %H:%M"
			result = [timestamp]+ordered_breakdown.map{|e| e.last}
			p [b]+result
			csv << result
			sleep 1			
			File.write(headers_path,headers)			
		end
	end
	# csv << ["date"]+headers	
end

CSV.open(clean_headers_path,"wb",col_sep: "\t") do |csv|
	csv << headers
end

system "cat #{clean_headers_path} #{data_path} > #{result_path}"

system "cp #{result_path} #{views_path}"