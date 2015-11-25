end_block = ARGV[0].to_i 

num_of_blocks = ARGV[1].to_i-1 

slice_size = ARGV[2].to_i 

start_block = end_block - num_of_blocks

path = __dir__+'/coinsecrets_from.rb'

(start_block..end_block).to_a.reverse.each_slice(slice_size) do |slice|
	system "ruby #{path} #{slice.size} #{slice.max}"
end