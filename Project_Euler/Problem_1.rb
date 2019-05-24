#Multiples of 3 and 5

def multiples
    sum = 0
    1000.times do |x|
        if x % 3 == 0 or x % 5 == 0 
            sum += x
        end
    end
    return sum
end

puts multiples