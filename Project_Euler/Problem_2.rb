#Even Fibonacci numbers

def even_fib
    prev_1 = 1
    prev_2 = 2
    sum = 2

    while prev_2 < 4000000
        if (prev_1 + prev_2) % 2 == 0
            sum += prev_1 + prev_2
        end
        temp = prev_1
        prev_1 = prev_2
        prev_2 = temp + prev_2
    end
    return sum
end

puts even_fib