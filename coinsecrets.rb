require 'open-uri'
require 'net/http'
require 'json'
require 'csv'

# def call_api(url)
# 	Net::HTTP.get(URI(url))		
# end



coinsecrets_url = 'http://api.coinsecrets.org/block/'


num_of_weeks = 10

end_block = 383233
num_of_blocks = 6*24*7*num_of_weeks
# num_of_blocks = 10
start_block = end_block - num_of_blocks
file_name = "results_#{start_block}_#{end_block}.txt"

f = File.open(file_name,'a+')
p "This should take #{num_of_blocks/3600} hours"

result = {}
result['max_block']=end_block;

(start_block..end_block).to_a.reverse.map do |b|
	url = base_url+b.to_s
	response = JSON.parse(call_api(url))
	op_returns=response['op_returns']
	protocols = op_returns.map{|o| o['protocols']}
	protocol_names = protocols.map{|p| p.first['name'] if p.count>0}
	breakdown = protocol_names.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
	breakdown.keys.each do |k,v| 
		breakdown['unknown'] = breakdown.delete(k) unless k 
	end
	breakdown.each do |k,v| 
		result[k] ? result[k] += v.to_i : result[k] = v.to_i
	end
	result['min_block']=b;
	File.write(file_name,result.to_s)
	# p result
	sleep 1	
end

results_array = result.sort

CSV.open(csv_path,"wb",col_sep: ",") do |csv|
	csv << ["Protocol","Transactions"]
	results_array.each do |row|
		csv << row
	end
end