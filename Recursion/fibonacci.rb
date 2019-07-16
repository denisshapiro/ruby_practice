def fibs(n)
  (0...n).each_with_object([]) do |x, array|
    array << x if x < 2
    array << array[x - 1] + array[x - 2] unless x < 2
  end
end

def fibs_rec(n, arr = [0, 1])
  if n <= 1
    return n
  elsif arr.length == n + 1
    return arr[-1]
  else
    fibs_rec(n, arr << (arr[-1] + arr[-2]))
  end

  arr
end

p fibs(10000)
p fibs_rec(10000)