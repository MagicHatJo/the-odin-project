def fibs(num)
	arr = num < 1 ? [0] : [0, 1]
	(num - 1).times { arr << arr[-1] + arr[-2] }
	return arr
end

def fibs_rec(num)
	return [0] if num <= 0
	return [0, 1] if num == 1
	arr = fibs_rec(num - 1)
	return arr << arr[-1] + arr[-2]
end