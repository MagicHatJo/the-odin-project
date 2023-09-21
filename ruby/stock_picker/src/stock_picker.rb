def stock_picker(stock_prices)

	return nil if stock_prices.length < 1
	
	peak = {
		front: 0,
		back: 0,
		profit: 0
	}

	min_index = 0

	stock_prices.each_with_index do |price, index|
		if price > stock_prices[min_index] then
			if price - stock_prices[min_index] > peak[:profit] then
				peak[:front]  = min_index
				peak[:back]   = index
				peak[:profit] = price - stock_prices[min_index]
			end
		else
			min_index = index
		end
	end

	return [peak[:front], peak[:back]]
end