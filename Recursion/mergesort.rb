def merge_sort(arr)
  if arr.length <= 1
    arr
  else
    left = merge_sort(arr[0...arr.size/2])
    right = merge_sort(arr[arr.size/2..arr.size])
    merge(left, right)
  end
end

def merge(l1, l2, arr = [])
  if l1.empty? && l2.empty?
    arr
  elsif l1.empty? && !l2.empty?
    arr + l2
  elsif !l1.empty? && l2.empty?
    arr + l1
  elsif l1.first <= l2.first
    arr << l1.shift
    merge(l1, l2, arr)
  elsif l1.first >= l2.first
    arr << l2.shift
    merge(l1, l2, arr)
  end
end

p merge_sort([2, 3, 6, 12, 4, 45, 1])
p merge_sort([-21, 10, -44, 99, 0])
p merge_sort([5, 1, 3, 4, 2])

rand_arr = 1000.times.map{Random.rand(-1_000_000..1_000_000) }
p merge_sort(rand_arr)