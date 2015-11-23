
require 'csv'
# headers = ["date", "Factom", "unknown", "Proof of Existence", "Open Assets", "Colu", "Blockstore", "Eternity Wall", "Ascribe", "Monegraph", "Stampery", "Omni Layer", "Bitproof", "CoinSpark", "LaPreuve", "BlockSign", "Remembr", "stampd", 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

headers = ["date", "Factom", "unknown", "Proof of Existence", "Open Assets", "Colu", "Blockstore", "Eternity Wall", "Ascribe", "Monegraph", "Stampery", "Omni Layer", "Bitproof", "CoinSpark", "LaPreuve", "BlockSign", "Remembr", "stampd", "Crypto Copyright", "OriginalMy", 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]



start_block = 371904
end_block = 379904


dir_name = "#{start_block}_#{end_block}"
file_name = "data"
file_dir = "../data/#{dir_name}/"

data_path = file_dir+'data.tsv'
older_file_path = 'data/result.tsv'
headers_path = file_dir+'headers.txt'
block_path = file_dir+'block.tsv'
clean_headers_path = file_dir+'clean_headers.txt'
result_path = file_dir+'result.tsv'
views_path = __dir__+'/../views/data/data.tsv'


CSV.open(clean_headers_path,"wb",col_sep: "\t") do |csv|
	csv << headers
end

system "cat #{clean_headers_path} #{data_path} > #{result_path}"

system "cp #{result_path} #{views_path}"