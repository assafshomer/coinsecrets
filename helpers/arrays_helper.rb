module ArraysHelper
	require 'matrix'
	require 'time'
	def get_categories(array,opts={})
		array.shift if opts[:csv] #ignore headers if CSV
		array.map{|t| t.first}.uniq
	end

	def aggregate_by_category(array,categories)			
		categories.map do |category| 
			elements = array.select{|element| element.first == category}
			elements.each do |element|
				element.shift
			end
		end			
	end
	def integerize(array)
		array.map { |e| e.to_i }
	end

	def sum_by_category(array,categories,opts={})
		aggregated_data = aggregate_by_category(array,categories)
		result = aggregated_data.map do |category_data|
			vector_sum(category_data,opts)
		end
		opts[:cum] ? add_cumulate(result) : result
	end

	def add_cumulate(array)
		sums = array.map{|e| e.last}
		cum = sums.cumulative_sum
		array.zip(cum.reverse).map{|e| e.flatten}
	end	

	def vector_sum(array,opts={})
		data = array.inject do |result, element|				
			Vector.elements(integerize(result)) + Vector.elements(integerize(element))
		end.to_a
		opts[:sum] ? data << data.inject(&:+) : data
	end

	def group_by_first_element(array,opts={})
		categories = get_categories(array)		
		categorized_data = sum_by_category(array,categories,opts)		
		categories.zip(categorized_data).map{|e| e.flatten}
	end

	def zoom_out_to_days(array)
		days =  array.each_with_index.map do |line,index|
			if index == 0 # leave headers alone
				line
			else				
				line.each_with_index.map do |x,i|
					if i == 0 #only process the date column
					 	Time.parse(x).strftime "%Y-%m-%d"
					else
					 	x
					end 
				end
			end
		end		
	end

	def group_by_days(array,opts={})
		array_by_date = zoom_out_to_days(array)
		days = get_categories(array_by_date, {csv: true})
		categorized_data = sum_by_category(array_by_date,days,opts)		
		result = days.zip(categorized_data).map{|e| e.flatten}		
		result = result.map{|e| e.map{|x| x.to_s.strip}}
		array.first << "31" if opts[:sum]
		labels = opts[:sum] ? array.first << "Total" : array.first
		labels = opts[:sum] && opts[:cum] ? array.first << "Cummulative" : array.first
		[labels] + result
	end

	# def insert_total(categorized_array)
	# 	categories = categorized_array.map{|e| e.shift}
	# 	sum = vector_sum(categorized_array)
	# 	extended_categories = ['total']+categories
	# 	extended_data = categorized_array.unshift(sum)
	# 	extended_categories.zip(extended_data).map{|e| e.flatten}
	# end

end

class Array
  def cumulative_sum
    sum = 0
    self.map{|x| sum += x}
  end
end