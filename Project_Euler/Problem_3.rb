#Largest prime factor

require 'prime'

def largest
    x = Math.sqrt(600851475143).to_i - 1
    while x > 2
        if (600851475143 % x == 0) && Prime.prime?(x)
            return x
        end
        x -= 2
    end
end

puts largest
