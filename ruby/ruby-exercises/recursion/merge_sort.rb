def merge(left, right)
	arr = []
	l = 0
	r = 0

	while l < left.length || r < right.length do
		if r == right.length || (l < left.length && left[l] <= right[r])
			arr << left[l]
			l += 1
		else
			arr << right[r]
			r += 1
		end
	end

	return arr
end

def merge_sort(arr)
	return arr if arr.length < 2
	return merge(
		merge_sort(arr[0...(arr.length / 2)]),
		merge_sort(arr[(arr.length / 2)..-1])
	)
end