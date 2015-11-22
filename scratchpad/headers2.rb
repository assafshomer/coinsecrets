# cs = %w(Faxctom	unknown	Ascribe	Open Assets	Proof of Existence	Monegraph	Eternity Wall	BlockSign	Colu	Omni Layer	Stampery	Remembr	Bitproof	Blockstore	fooFactom CoinSpark	stampd)




initial_size = 10

headers = (1..initial_size).to_a

protocols = headers.reject{|x| x.is_a?(Integer)}

p protocols

keys = %w(foo bar buzz)

new_keys = keys - (headers & keys)

p new_keys

headers.shift(new_keys.count)

p headers

headers = new_keys + headers

keys = %w(foo bar quuax fuzz)

new_keys = keys - (headers & keys)

p new_keys



# p cs.find_index{|e| e=~/Factom/}

# header


# p cs.size

# p Time.at(1429690641).strftime "%Y-%m-%d %H:%M"

# h = (1..10).to_a.map{|e| 'ph_'+e.to_s}

# p h


# p h

# h.push('blarg')

# p h 
