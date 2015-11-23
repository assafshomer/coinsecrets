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

num_of_blocks = ARGV[1].to_i-1 || 6*24*365/3 

slice_size = ARGV[2].to_i || 10

start_block = end_block - num_of_blocks

headers = ["date", "Factom", "unknown", "Proof of Existence", "Open Assets", "Colu", "Blockstore", "Eternity Wall", "Ascribe", "Monegraph", "Stampery", "Omni Layer", "Bitproof", "CoinSpark", "LaPreuve", "BlockSign", "Remembr", "stampd", "Crypto Copyright", "OriginalMy", 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

dir_name = "#{start_block}_#{end_block}"
file_name = "data"
file_dir = "data/#{dir_name}/"
FileUtils.mkdir_p(file_dir)
data_path = file_dir+'data.tsv'
base_file_path = 'data/data.tsv'
headers_path = file_dir+'headers.txt'
block_path = file_dir+'block.tsv'
clean_headers_path = file_dir+'clean_headers.txt'
result_path = file_dir+'result.tsv'
views_path = __dir__+'/../views/data/data.tsv'


CSV.open(data_path,"wb",col_sep: "\t") do |csv|
	CSV.open(block_path,"wb") do |bcsv|	
		(start_block..end_block).to_a.reverse.each_slice(slice_size) do |slice|
			p "processing slice #{slice}"
			slice.map do |b|
				breakdown, result, op_returns = {},[], nil
				url = coinsecrets_base_url+b.to_s
				data = ApiCaller.new(url,false).data
				response = JSON.parse(data)
				op_returns=response['op_returns']		
				if (op_returns.nil? || op_returns.empty?)
					bcsv << [b]
				else
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
					bcsv << [b]+result
					csv << result
					sleep 1			
					File.write(headers_path,headers)
				end			
			end
			CSV.open(clean_headers_path,"wb",col_sep: "\t") do |csv|
				csv << headers
			end
			system "cat #{base_file_path} #{data_path} > #{result_path}"
			system "cp #{result_path} #{base_file_path}"
			system "cp #{base_file_path} #{views_path}"			
		end
	end
end

# CSV.open(clean_headers_path,"wb",col_sep: "\t") do |csv|
# 	csv << headers
# end

# system "cat #{base_file_path} #{data_path} > #{result_path}"

# system "cp #{result_path} #{base_file_path}"

# system "cp #{base_file_path} #{views_path}"