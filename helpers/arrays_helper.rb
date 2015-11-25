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

	def sum_by_category(array,categories)
		aggregated_data = aggregate_by_category(array,categories)
		aggregated_data.map do |category_data|
			category_data.inject do |result, element|				
				Vector.elements(integerize(result)) + Vector.elements(integerize(element))
			end.to_a
		end
	end

	def group_by_first_element(array)
		categories = get_categories(array)
		categorized_data = sum_by_category(array,categories)
		categories.zip(categorized_data).map{|e| e.flatten}
	end

	def zoom_out_to_days(array)
		days =  array.each_with_index.map do |line,index|
			if index == 0 # leave headers along
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

	def group_by_days(array)
		array_by_date = zoom_out_to_days(array)
		days = get_categories(array_by_date, {csv: true})
		categorized_data = sum_by_category(array_by_date,days)
		result = days.zip(categorized_data).map{|e| e.flatten}
		result = result.map{|e| e.map{|x| x.to_s}}
		[array.first] + result
	end



end