def add(a, b)#write your code here
    return a + b  
end

def subtract(a, b)
    return a - b
end

def sum(arr)
    sum = 0

    arr.length.times do |x|
        sum += arr[x]
    end
    return sum
end

def multiply(*n)
    prod = 1
    n.length.times do |x|
        prod *= n[x]
    end
    return prod
end

def power(a, b)
    return a ** b   
end

def factorial(n)
    fact = 1
    if n == 0
        return 0
    end

    while n > 0
        fact *= n
        n -= 1
    end
    return fact
end