def bubble_sort(arr)
	
	arr.each do
		arr[0...-1].each_with_index do |val, i|
			k = i + 1
			arr[i], arr[k] = arr[k], arr[i] if arr[i] > arr[k]
		end
	end
	arr
end