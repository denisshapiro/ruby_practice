def smallest_multiple(n = 2520)
  until div_1_to_20(n)
    n += 2520
  end
  n
end

def div_1_to_20(num)
  (1..20).to_a.all? do |i|
    (num % i).zero?
  end
end

p smallest_multiple