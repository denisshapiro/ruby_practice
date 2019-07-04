def stock_picker(arr)
    maxProfit = 0;
    buySellArr = [0, 0]
    currentBuy = arr[0]
    currentSell = arr[0]

    arr.each_with_index do |element, index|
        if element < currentBuy
            currentBuy = element
            currentSell = arr[index + 1]
            if currentSell - currentBuy > maxProfit
                maxProfit = currentSell - currentBuy
                buySellArr = [arr.find_index(currentBuy), arr.find_index(currentSell)]
            end

        elsif element > currentSell
            currentSell = element
            if currentSell - currentBuy > maxProfit
                maxProfit = currentSell - currentBuy
                buySellArr = [arr.find_index(currentBuy), arr.find_index(currentSell)]
            end
        end
    end

    return buySellArr
end


puts stock_picker([17,3,6,9,15,8,6,1,10])
