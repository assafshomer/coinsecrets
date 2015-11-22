
require 'csv'
headers = ["date", "Factom", "unknown", "Proof of Existence", "Open Assets", "Colu", "Blockstore", "Eternity Wall", "Ascribe", "Monegraph", "Stampery", "Omni Layer", "Bitproof", "CoinSpark", "LaPreuve", "BlockSign", "Remembr", "stampd", 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]



start_block = 377799
end_block = 384799

file_name = "data_#{start_block}_#{end_block}"
file_dir = __dir__+'/../data/'

data_path = file_dir+file_name+'.csv'
clean_headers_path = file_dir+file_name+'_clean_headers.txt'
result_path = file_dir+file_name+'_result.csv'
views_path = __dir__+'/../views/data/data.tsv'


CSV.open(clean_headers_path,"wb",col_sep: "\t") do |csv|
	csv << headers
end

system "cat #{clean_headers_path} #{data_path} > #{result_path}"

system "cp #{result_path} #{views_path}"