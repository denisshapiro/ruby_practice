def bubble_sort(arr)
    swaps = true
    while swaps == true do
        swaps = false
        (arr.length-1).times do |x|
            if arr[x] > arr[x+1]
                arr[x], arr[x+1] = arr[x+1], arr[x]
                swaps = true
            end
        end
    end
    return arr
end 

def bubble_sort_by(arr)
    swaps = true
    while swaps == true do
        swaps = false
        (arr.length-1).times do |x|
            if yield(arr[x], arr[x+1]) > 0
                arr[x], arr[x+1] = arr[x+1], arr[x]
                swaps = true
            end
        end
    end
    return arr
end

p bubble_sort([4,3,78,2,0,2])

p bubble_sort_by(["hi","hello","hey"]) {|left,right| left.length - right.length}
