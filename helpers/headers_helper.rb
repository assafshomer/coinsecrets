module HeadersHelper

	def insert(headers_array, new_keys_array)
		new_keys = find_new_keys(headers_array,new_keys_array)
		position = find_next_position(headers_array)
		headers = get_headers(headers_array)
		placeholders = get_placeholders(headers_array)
		placeholders.shift(new_keys.count)
		headers + new_keys + placeholders
	end

	def complete(new_keys_array)
		base = ["date"]+(1..30).to_a
		insert(base,new_keys_array)
	end

	def find_new_keys(array, candidate_keys)
		candidate_keys - (array & candidate_keys)
	end

	def find_next_position(array)
		first_int = array.select{|x| x.is_a?(Integer)}.first
		array.index(first_int)
	end

	def get_headers(array)
		array.reject{|x| x.is_a?(Integer)}
	end

	def get_placeholders(array)
		array.select{|x| x.is_a?(Integer)}
	end
	
	def order_hash_by_array(hash,keys_array)
		hbar = {}
		keys_array.each do |key|
			hbar[key] =hash[key]
		end
		return hbar
	end	

end