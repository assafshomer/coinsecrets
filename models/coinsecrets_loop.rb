num_of_blocks = ARGV[0].to_i
slice_size = [ARGV[1].to_i,1].max
num_of_loops = num_of_blocks/slice_size

path = __dir__+'/coinsecrets_from.rb'
p "Looping #{num_of_loops} times, each time with slice of size #{slice_size}"
num_of_loops.times do
	system "ruby #{path} #{slice_size}"
end