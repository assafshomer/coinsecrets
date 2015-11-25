require 'open-uri'
require 'net/http'
require 'json'
require 'csv'
require 'tempfile'
require 'byebug'
require 'fileutils'
require __dir__+'/../helpers/api_helper'
require __dir__+'/../helpers/headers_helper'
require __dir__+'/../helpers/arrays_helper'
include HeadersHelper
include ArraysHelper

dir_name = 'processing'
file_name = "data"
file_dir = "data/#{dir_name}/"
FileUtils.mkdir_p(file_dir)
data_path = file_dir+'data.tsv'
base_file_path = file_dir+'base.tsv'
final_path = file_dir+'final.tsv'
headers_path = file_dir+'headers.txt'
block_path = file_dir+'block.tsv'
last_block_path = file_dir+'last_block.tsv'
blocks_path = file_dir+'blocks.tsv'
tmp_path = file_dir+'tmp.tsv'
clean_headers_path = file_dir+'clean_headers.txt'
result_path = file_dir+'result.tsv'
views_path = __dir__+'/../views/data/data.tsv'

coinsecrets_base_url = 'http://api.coinsecrets.org/block/'
toshi_base_url = 'https://bitcoin.toshi.io/api/v0/blocks/'
toshi_latest = ApiCaller.new(toshi_base_url+'latest',true).data

end_block = ARGV[1].to_i
end_block = (CSV.read(last_block_path).flatten.first.to_i) -1 if end_block == 0
end_block = JSON.parse(toshi_latest)["height"] if end_block <= 0

num_of_blocks = ARGV[0].to_i-1
num_of_blocks = 2 if num_of_blocks < 0

start_block = end_block - num_of_blocks

# headers = ["date", "Factom", "unknown", "Proof of Existence", "Open Assets", "Colu", "Blockstore", "Eternity Wall", "Ascribe", "Monegraph", "Stampery", "Omni Layer", "Bitproof", "CoinSpark", "LaPreuve", "BlockSign", "Remembr", "stampd", "Crypto Copyright", "OriginalMy", 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

# dir_name = "#{start_block}_#{end_block}"


headers = CSV.read(clean_headers_path,col_sep: "\t").flatten
headers = headers.map{|h| h.to_i > 0 ? h.to_i : h}
headers = complete(headers)
# system "find #{file_dir} -mindepth 1 -delete"

CSV.open(data_path,"wb",col_sep: "\t") do |csv|
	CSV.open(block_path,"wb") do |bcsv|	
		(start_block..end_block).to_a.reverse.map do |b|
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
				ordered_breakdown.delete("date")
				timestamp = Time.at(response['timestamp'].to_i).strftime "%Y-%m-%d %H:%M"
				result = [timestamp]+ordered_breakdown.map{|e| e.last}
				p [b]+result
				bcsv << [b]+result
				csv << result unless result.first =~ /\A1970-01-01/
				sleep 1			
				File.write(headers_path,headers)
				File.write(last_block_path,b)
			end			
		end
	end
end


File.write(clean_headers_path,'')
CSV.open(clean_headers_path,"wb",col_sep: "\t") do |csv|
	csv << headers
end

system "cat #{base_file_path} #{data_path} > #{tmp_path}"
system "cp #{tmp_path} #{base_file_path}"

File.write(tmp_path,'')

system "cat #{clean_headers_path} #{base_file_path} > #{result_path}"

system "cat #{blocks_path} #{block_path} > #{tmp_path}"
system "cp #{tmp_path} #{blocks_path}"


File.write(tmp_path,'')

data = CSV.read(result_path,col_sep: "\t")
cummed_data = group_by_days(data,{sum: true, cum: true})

CSV.open(final_path,"wb",col_sep: "\t") do |csv|
	cummed_data.each do |row|
		csv << row
	end
end


# system "cp #{base_file_path} #{views_path}"

# system "cp #{cum_path} #{views_path}"

# system "cat #{base_file_path} #{data_path} > #{result_path}"

system "cp #{final_path} #{views_path}"

